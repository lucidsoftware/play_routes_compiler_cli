workspace(name = "play_routes_compiler_cli")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_jvm_external
RULES_JVM_EXTERNAL_TAG = "d716bbe2dbaa068e495d25aeb1dcaa699f134eed"
http_archive(
    name = "rules_jvm_external",
    sha256 = "d2bab2d2aefbadb2207ada5b82a7da99b7ff3f03ae565cbc194f124752d8bd06",
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


# higherkindness/rules_scala
rules_scala_annex_version = "lucid_2023-12-13" # update this as needed
http_archive(
    name = "rules_scala_annex",
    integrity = "sha256-cr+XAL/P6b1sgGi3FBEmqMgzScvu+3kAEmwz68lKei4=",
    strip_prefix = "rules_scala-{}".format(rules_scala_annex_version),
    type = "zip",
    url = "https://github.com/lucidsoftware/rules_scala/archive/{}.zip".format(rules_scala_annex_version),
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

register_toolchains("//:java_toolchain_definition")

# Protobuf
protobuf_version = "25.1"
http_archive(
    name = "com_google_protobuf",
    sha256 = "eaafa4e19a6619c15df4c30d7213efbfd0f33ad16021cc5f72bbc5d0877346b5",
    strip_prefix = "protobuf-{}".format(protobuf_version),
    type = "zip",
    url = "https://github.com/protocolbuffers/protobuf/archive/v{}.zip".format(protobuf_version),
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

####################### For Maven Publishing ############################
skylib_version = "1.4.1"
http_archive(
    name = "bazel_skylib",
    sha256 = "b8a1527901774180afc798aeb28c4634bdccf19c4d98e7bdd1ce79d1fe9aaad7",
    type = "tar.gz",
    url = "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{}/bazel-skylib-{}.tar.gz".format(skylib_version, skylib_version),
)

graknlabs_bazel_distribution_version = "ebb4660cff37574876d37bf7c498bd735155554f"
http_archive(
    name = "graknlabs_bazel_distribution",
    sha256 = "c3181786d2544a7df54bcf326d5e40e6ec0b86dbc6c42e58d40f8c2c2225859f",
    strip_prefix = "bazel-distribution-{}".format(graknlabs_bazel_distribution_version),
    type = "zip",
    url = "https://github.com/graknlabs/bazel-distribution/archive/{}.zip".format(graknlabs_bazel_distribution_version),
)

# Make COMPILER_CLI_ARTIFACT_ID available in BUILD files
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
  env_vars = ["COMPILER_CLI_ARTIFACT_ID"]
)
####################################################################

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
