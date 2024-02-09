"""
Load test 3rd party maven dependencies
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")
load(":workspace.bzl", "play_version")

specs2_version = "4.20.3"

def play_routes_compiler_cli_test_repositories():
    maven_install(
        name = "play_routes_compiler_cli_test_maven",
        artifacts = [
            "org.specs2:specs2-common_2.13:{}".format(specs2_version),
            "org.specs2:specs2-core_2.13:{}".format(specs2_version),
            "org.specs2:specs2-matcher_2.13:{}".format(specs2_version),
            "com.typesafe.akka:akka-actor_2.13:2.6.21",
            "com.typesafe.play:play_2.13:{}".format(play_version),
            "com.typesafe.play:play-test_2.13:{}".format(play_version),
            "com.typesafe.play:play-specs2_2.13:{}".format(play_version),
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "//:play_routes_compiler_cli_test_maven_install.json",
    )
