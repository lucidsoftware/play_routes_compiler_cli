"""
Load 3rd party maven dependencies
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")

def play_routes_compiler_cli_repositories():
    maven_install(
        name = "play_routes_compiler_cli_maven",
        artifacts = [
            "com.github.scopt:scopt_2.12:3.7.0",
            "com.typesafe.play:routes-compiler_2.12:2.8.7",
            "org.scala-sbt:zinc_2.12:1.2.1",
            "org.scala-sbt:compiler-interface:1.2.1",
            "org.scala-sbt:util-interface:1.2.0",
            "org.scala-lang:scala-compiler:2.12.10",
            "org.scala-lang:scala-library:2.12.10",
            "org.scala-lang:scala-reflect:2.12.10",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "//:play_routes_compiler_cli_maven_install.json",
    )
