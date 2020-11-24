workspace(name = "play_routes_compiler_cli")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_jvm_external
RULES_JVM_EXTERNAL_TAG = "3.3"
http_archive(
    name = "rules_jvm_external",
    sha256 = "d85951a92c0908c80bd8551002d66cb23c3434409c814179c0ff026b53544dab",
    strip_prefix = "rules_jvm_external-{}".format(RULES_JVM_EXTERNAL_TAG),
    type = "zip",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.zip".format(RULES_JVM_EXTERNAL_TAG),
)

load("//:workspace.bzl", "play_routes_compiler_cli_repositories")
play_routes_compiler_cli_repositories()
load("@play_routes_compiler_cli_maven//:defs.bzl", play_routes_compiler_cli_pinned_maven_install = "pinned_maven_install")
play_routes_compiler_cli_pinned_maven_install()

load("//:test_workspace.bzl", "play_routes_compiler_cli_test_repositories")
play_routes_compiler_cli_test_repositories()
load("@play_routes_compiler_cli_test_maven//:defs.bzl", play_routes_compiler_cli_test_pinned_maven_install = "pinned_maven_install")
play_routes_compiler_cli_test_pinned_maven_install()

# bazelbuild/rules_scala

skylib_version = "1.0.3"
http_archive(
    name = "bazel_skylib",
    sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    type = "tar.gz",
    url = "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{}/bazel-skylib-{}.tar.gz".format(skylib_version, skylib_version),
)

rules_scala_version = "9bd9ffd3e52ab9e92b4f7b43051d83231743f231"
http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "438bc03bbb971c45385fde5762ab368a3321e9db5aa78b96252736d86396a9da",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    type = "zip",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
)

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
scala_config(scala_version = "2.13.3")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()
load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

# higherkindness/rules_scala
rules_scala_annex_version = "ff423d8bdd0e5383f8f2c048ffd7704bb51a91bf" # update this as needed
http_archive(
    name = "rules_scala_annex",
    sha256 = "ae53e9ed5fecadc7baf4637b88109471602be73dda4e5ff6b4bf1767932703c0",
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

# Make TRAVIS_TAG available in BUILD files
env_vars_to_bzl_vars_version = "d67a600bb0917cd0e1c7a17ee78a3e2110fdbde2"
http_archive(
  name = "env_vars_to_bzl_vars",
  sha256 = "f0f7077a83590ff566c8ef17b74ca02728592f6f400eecb6d3ccef8997a9f41d",
  type = "zip",
  strip_prefix ="env_vars_to_bzl_vars-{}".format(env_vars_to_bzl_vars_version),
  url = "https://github.com/SrodriguezO/env_vars_to_bzl_vars/archive/{}.zip".format(env_vars_to_bzl_vars_version)
)

load("@env_vars_to_bzl_vars//:env_vars_loader.bzl", "load_env_vars")
load_env_vars(
  name = "env_vars",
  env_vars = ["COMPILER_CLI_ARTIFACT_ID", "COMPILER_CLI_VERSION"]
)

## For tests
play_version = "2.7" # This doesn't actually matter, since we're not using the default compilers rules_play_routes provides
rules_play_routes_version = "8dbe5ee4359c30cfb7d368fed9b2df59c9665eb1"

http_archive(
  name = "io_bazel_rules_play_routes",
  sha256 = "d93e6d53440a53da4c33f78736b8b78c9a1e84623bcccd6a1cbff55e1c318c97",
  strip_prefix = "rules_play_routes-{}".format(rules_play_routes_version),
  type = "zip",
  url = "https://github.com/lucidsoftware/rules_play_routes/archive/{}.zip".format(rules_play_routes_version),
)

load("@io_bazel_rules_play_routes//:workspace.bzl", "play_routes_repositories")
play_routes_repositories(play_version)
load("@play_routes//:defs.bzl", play_routes_pinned_maven_install = "pinned_maven_install")
play_routes_pinned_maven_install()
