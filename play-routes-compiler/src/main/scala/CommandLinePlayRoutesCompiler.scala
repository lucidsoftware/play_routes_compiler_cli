package rulesplayroutes.routes

import com.google.devtools.build.buildjar.jarhelper.JarCreator
import higherkindness.rules_scala.common.error.AnnexWorkerError
import higherkindness.rules_scala.common.worker.WorkerMain
import java.io.{File, PrintStream}
import java.nio.file.{Files, Paths}
import play.routes.compiler._
import play.routes.compiler.RoutesCompiler.RoutesCompilerTask
import scala.jdk.CollectionConverters._
import scala.io.Source
import scala.Console._
import scopt.OptionParser

object CommandLinePlayRoutesCompiler extends WorkerMain[Unit] {

  case class Config(
    sources: Seq[File] = Seq.empty[File],
    generatedDirectory: File = new File("."),
    outputSrcJar: File = new File("."),
    additionalImports: Seq[String] = Seq.empty[String],
    routesGenerator: RoutesGenerator = InjectedRoutesGenerator,
    generateReverseRouter: Boolean = false,
    namespaceReverserRouter: Boolean = false,
    generateForwardsRouter: Boolean = true
  )

  val parser = new OptionParser[Config]("scopt") {
    head("Command Line Play Routes Compiler", "0.1")

    arg[File]("<outputDirectory>").required().action { (value, config) =>
      config.copy(generatedDirectory = value)
    }.text("directory to output compiled routes to")

    arg[File]("<outputSrcJar>").required().action { (value, config) =>
      config.copy(outputSrcJar = value)
    }.text("file to output srcjar containing compiled routes to")

    arg[Seq[File]]("<source1>,<source2>...").unbounded().required().action { (value, config) =>
      config.copy(sources = value)
    }.text("routes to compile")

    opt[String]('i', "routesImport").valueName("<import>").unbounded().action { (value, config) =>
      config.copy(additionalImports = config.additionalImports ++ Seq(value))
    }.text("Imports for the router")

    opt[String]('g', "routesGenerator").valueName("<generator>").maxOccurs(1).action { (value, config) =>
      config.copy(routesGenerator = {
        try {
          val name = if value.endsWith("$") then value else value + "$"
          val clazz = java.lang.Class.forName(name, true, getClass.getClassLoader)
          clazz.getField("MODULE$").get(null).asInstanceOf[RoutesGenerator]
        } catch {
          case e: Exception => {
            throw new Exception(
              s"Could not instantiate a routes generator from the given class: ${value}",
              e,
            )
          }
        }
      })
    }.text("The full class of the routes generator, e.g., play.routes.compiler.InjectedRoutesGenerator")

    opt[Unit]('r', "generateReverseRouter").maxOccurs(1).action { (value, config) =>
      config.copy(generateReverseRouter = true)
    }.text("Whether the reverse router should be generated. Setting to false may reduce compile times if it's not needed.")

    opt[Unit]('n', "namespaceReverserRouter").maxOccurs(1).action { (value, config) =>
      config.copy(namespaceReverserRouter = true)
    }.text("Whether the reverse router should be namespaced. Useful if you have many routers that use the same actions.")

    opt[Boolean]('f', "generateForwardsRouter").maxOccurs(1).action { (value, config) =>
      config.copy(generateForwardsRouter = value)
    }.text("Whether the forwards router should be generated. Setting this to false should allow us to only generate reverse routes for a project")
  }

  // The generated Routes files include non-reproducible headers
  // We need to remove these for Bazel caching to work
  private def stripHeader(path: String): Unit = {
    val lines = Source.fromFile(path).getLines()
    val sansHeader = lines.span(line => line.matches("^(//.*|\\s*)$"))._2.toList
    Files.write(Paths.get(path), sansHeader.asJava)
  }

  /**
   * Do Play Routes compilation and return true if things succeeded, otherwise return false.
   */
  def compilePlayRoutes(config: Config): Boolean = {
    config.sources.forall { file =>
      RoutesCompiler.compile(
        RoutesCompilerTask(
          file,
          config.additionalImports,
          config.generateForwardsRouter,
          config.generateReverseRouter,
          config.generateReverseRouter,
          config.namespaceReverserRouter
        ),
        config.routesGenerator,
        config.generatedDirectory
      ) match {
        case Right(generatedFiles) =>
          generatedFiles.foreach { f =>
            stripHeader(f.getPath)
          }
          true
        case Left(errors) =>
          Console.err.println(s"${RESET}${RED}Play Routes Compilation Error:${RESET} Failed to compile routes for ${file}. Errors: ${errors}")
          false
      }
    }
  }

  def generateJar(config: Config): Unit = {
    val jarCreator = new JarCreator(config.outputSrcJar.toPath())
    jarCreator.addDirectory(config.generatedDirectory.toPath())
    jarCreator.setCompression(false)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)
    jarCreator.execute()
  }

  override def init(args: Option[Array[String]]): Unit = ()

  protected def work(ctx: Unit, args: Array[String], out: PrintStream): Unit = {
    val finalArgs = args.toList.flatMap {
      case arg if arg.startsWith("@") => Files.readAllLines(Paths.get(arg.tail)).asScala
      case arg => Array(arg)
    }
    val config = parser.parse(finalArgs, Config()).getOrElse(throw new AnnexWorkerError(1))

    if (compilePlayRoutes(config)) {
      generateJar(config)
    } else {
      throw new AnnexWorkerError(1)
    }
  }
}