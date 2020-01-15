"""
Load test 3rd party maven dependencies
"""

load("@rules_jvm_external//:defs.bzl", "maven_install")

def play_routes_compiler_cli_test_repositories():
    maven_install(
        name = "play_routes_compiler_cli_test_maven",
        artifacts = [
            "org.specs2:specs2-common_2.12:4.7.0",
            "org.specs2:specs2-core_2.12:4.7.0",
            "org.specs2:specs2-matcher_2.12:4.7.0",
            "com.typesafe.akka:akka-actor_2.12:2.5.24",
            "com.typesafe.play:play_2.12:2.7.4",
            "com.typesafe.play:play-test_2.12:2.7.4",
            "com.typesafe.play:play-specs2_2.12:2.7.4",
        ],
        repositories = [
            "http://central.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "//:play_routes_compiler_cli_test_maven_install.json",
    )
