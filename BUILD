load("@bazel_tools//tools/jdk:default_java_toolchain.bzl", "default_java_toolchain", "DEFAULT_JAVACOPTS")

default_java_toolchain(
    name = "java_toolchain",
    # some of the default options make scala compilation fail in the test package
    misc = [opt for opt in DEFAULT_JAVACOPTS if not opt.startswith("-Xep")],
    source_version = "11",
    target_version = "11",
)
