"""
Load 3rd party maven dependencies
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")
load("//scala:version.bzl", "scala3_version")

play_version = "3.0.4"
zinc_version = "1.10.1"

def play_routes_compiler_cli_repositories():
    maven_install(
        name = "play_routes_compiler_cli_maven",
        artifacts = [
            "com.github.scopt:scopt_3:4.1.0",
            "org.playframework:play-routes-compiler_3:{}".format(play_version),
            "org.scala-lang:scala3-compiler_3:{}".format(scala3_version),
            "org.scala-lang:scala3-library_3:{}".format(scala3_version),
            # Set neverlink = True to avoid Scala 2 library being pulled on to the compiler classpath
            maven.artifact("org.scala-lang", "scala3-sbt-bridge", scala3_version, neverlink = True),
            "org.scala-sbt:compiler-interface:{}".format(zinc_version),
            "org.scala-sbt:zinc_2.13:{}".format(zinc_version),
            "org.scala-sbt:util-interface:{}".format(zinc_version),
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "//:play_routes_compiler_cli_maven_install.json",
    )
