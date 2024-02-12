"""
Load 3rd party maven dependencies
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("//scala:version.bzl", "scala_version")

play_version = "2.9.1"

def play_routes_compiler_cli_repositories():
    maven_install(
        name = "play_routes_compiler_cli_maven",
        artifacts = [
            "com.github.scopt:scopt_2.13:3.7.1",
            "com.typesafe.play:play-routes-compiler_2.13:{}".format(play_version),
            "org.scala-lang:scala-compiler:{}".format(scala_version),
            "org.scala-lang:scala-library:{}".format(scala_version),
            "org.scala-lang:scala-reflect:{}".format(scala_version),
            "org.scala-sbt:compiler-bridge_2.13:1.10.0-M1",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "//:play_routes_compiler_cli_maven_install.json",
    )
