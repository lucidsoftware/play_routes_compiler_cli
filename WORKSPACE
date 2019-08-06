workspace(name = "compiler_cli")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_jvm_external
RULES_JVM_EXTERNAL_TAG = "2.5"
http_archive(
    name = "rules_jvm_external",
    sha256 = "249e8129914be6d987ca57754516be35a14ea866c616041ff0cd32ea94d2f3a1",
    strip_prefix = "rules_jvm_external-{}".format(RULES_JVM_EXTERNAL_TAG),
    type = "zip",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.zip".format(RULES_JVM_EXTERNAL_TAG),
)

load("//:workspace.bzl", "play_routes_repositories")
play_routes_repositories()

# higherkindness/rules_scala
rules_scala_annex_version = "584e319f61a7c15360831b367c9a092570df9659" # update this as needed
http_archive(
    name = "rules_scala_annex",
    sha256 = "9c9d9b0b4d995a0ed4aedfd6e3b201fe10cbb52b35c9bbec669138da56cd4f3b",
    strip_prefix = "rules_scala-{}".format(rules_scala_annex_version),
    type = "zip",
    url = "https://github.com/higherkindness/rules_scala/archive/{}.zip".format(rules_scala_annex_version),
)

bind(
    name = "default_scala",
    actual = "//scala:default_scala",
)

load("@rules_scala_annex//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")
scala_repositories()
load("@annex//:defs.bzl", annex_pinned_maven_install = "pinned_maven_install")
annex_pinned_maven_install()
scala_register_toolchains()

# JDK stuff needed for Scala 2.11
jdk_build_file_content = """
filegroup(
    name = "jdk",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)
filegroup(
    name = "java",
    srcs = ["bin/java"],
    visibility = ["//visibility:public"],
)
"""

http_archive(
    name = "jdk8-linux",
    build_file_content = jdk_build_file_content,
    sha256 = "dd28d6d2cde2b931caf94ac2422a2ad082ea62f0beee3bf7057317c53093de93",
    strip_prefix = "jdk8u212-b03",
    url = "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_linux_hotspot_8u212b03.tar.gz",
)

http_archive(
    name = "jdk8-osx",
    build_file_content = jdk_build_file_content,
    sha256 = "3d80857e1bb44bf4abe6d70ba3bb2aae412794d335abe46b26eb904ab6226fe0",
    strip_prefix = "jdk8u212-b03/Contents/Home",
    url = "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u212-b03/OpenJDK8U-jdk_x64_mac_hotspot_8u212b03.tar.gz",
)


# Protobuf
protobuf_version = "3.9.0"
http_archive(
    name = "com_google_protobuf",
    sha256 = "8eb5ca331ab8ca0da2baea7fc0607d86c46c80845deca57109a5d637ccb93bb4",
    strip_prefix = "protobuf-{}".format(protobuf_version),
    type = "zip",
    url = "https://github.com/protocolbuffers/protobuf/archive/v{}.zip".format(protobuf_version),
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

# bazel-common
bazelcommon_version = "0d4a76d35fe28caf5c887ff39bfd7374b993094b"
http_archive(
  name = "bazel-common",
  sha256 = "00f68b50b535e56daf563899cf6b924737d29127b8f2cb1fbcc473dbe4efad4a",
  type = "zip",
  strip_prefix = "bazel-common-{}".format(bazelcommon_version),
  url = "https://github.com/google/bazel-common/archive/{}.zip".format(bazelcommon_version)
)

load("@bazel-common//:workspace_defs.bzl", "google_common_workspace_rules")
google_common_workspace_rules()


## For tests
rules_play_routes_version = "6116a409bf1abcf78c4cfe1a8c55cfa01812bcc7"
http_archive(
  name = "io_bazel_rules_play_routes",
  sha256 = "9849753b2a524bee018fb929b1f1d8698d0604bb3fc21e5294420a908ca6cb47",
  strip_prefix = "rules_play_routes-{}".format(rules_play_routes_version),
  type = "zip",
  url = "https://github.com/lucidsoftware/rules_play_routes/archive/{}.zip".format(rules_play_routes_version),
)

load("@io_bazel_rules_play_routes//:workspace.bzl", "play_routes_repositories")
play_routes_repositories()
load("@play_routes//:defs.bzl", play_routes_pinned_maven_install = "pinned_maven_install")
play_routes_pinned_maven_install()

load("@io_bazel_rules_play_routes//:test_workspace.bzl", "play_routes_test_repositories")
play_routes_test_repositories()
load("@play_routes_test//:defs.bzl", play_routes_test_pinned_maven_install = "pinned_maven_install")
play_routes_test_pinned_maven_install()

