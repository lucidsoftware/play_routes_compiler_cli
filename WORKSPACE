workspace(name = "play_routes_compiler_cli")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_java
http_archive(
    name = "rules_java",
    sha256 = "647bb31c0d51882549def6f67ee9078df697043406ed4a5144bbdf3b17f91e33",
    urls = [
        "https://github.com/bazelbuild/rules_java/releases/download/7.8.0/rules_java-7.8.0.tar.gz",
    ],
)

load("@rules_java//java:repositories.bzl", "rules_java_dependencies")

rules_java_dependencies()

register_toolchains("//:repository_default_toolchain_21_definition")

# rules_jvm_external
rules_jvm_external_version = "6.2"

http_archive(
    name = "rules_jvm_external",
    sha256 = "aa39ecd47e16d5870eba817fe71476802bc371fe2724a2ddee565992df55f4af",
    strip_prefix = "rules_jvm_external-{}".format(rules_jvm_external_version),
    type = "zip",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.zip".format(rules_jvm_external_version),
)

load("//:workspace.bzl", "play_routes_compiler_cli_repositories")

play_routes_compiler_cli_repositories()

load("@play_routes_compiler_cli_maven//:defs.bzl", play_routes_compiler_cli_pinned_maven_install = "pinned_maven_install")

play_routes_compiler_cli_pinned_maven_install()

load("//:test_workspace.bzl", "play_routes_compiler_cli_test_repositories")

play_routes_compiler_cli_test_repositories()

load("@play_routes_compiler_cli_test_maven//:defs.bzl", play_routes_compiler_cli_test_pinned_maven_install = "pinned_maven_install")

play_routes_compiler_cli_test_pinned_maven_install()

# buildifier
buildtools_version = "4.2.2"

http_archive(
    name = "com_github_bazelbuild_buildtools",
    sha256 = "ae34c344514e08c23e90da0e2d6cb700fcd28e80c02e23e4d5715dddcb42f7b3",
    strip_prefix = "buildtools-{}".format(buildtools_version),
    url = "https://github.com/bazelbuild/buildtools/archive/refs/tags/{}.tar.gz".format(buildtools_version),
)

# buildifier is written in Go and hence needs rules_go to be built.
# See https://github.com/bazelbuild/rules_go for the up to date setup instructions.
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "6dc2da7ab4cf5d7bfc7c949776b1b7c733f05e56edc4bcd9022bb249d2e2a996",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.39.1/rules_go-v0.39.1.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.39.1/rules_go-v0.39.1.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies")

go_rules_dependencies()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains")

go_register_toolchains(version = "1.20.3")

# Also for buildifier. Comes from
# https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
protobuf_version = "3.19.4"

http_archive(
    name = "com_google_protobuf",
    sha256 = "3bd7828aa5af4b13b99c191e8b1e884ebfa9ad371b0ce264605d347f135d2568",
    strip_prefix = "protobuf-{}".format(protobuf_version),
    url = "https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(protobuf_version),
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

# higherkindness/rules_scala
rules_scala_annex_version = "c8c4345e3f354753ed4ae7830618467ab59262c6"

http_archive(
    name = "rules_scala_annex",
    integrity = "sha256-pmES8mOOeirB5woNYT2w97+5+C0Bt8ghrj9lHBKkMy8=",
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
    strip_prefix = "env_vars_to_bzl_vars-{}".format(env_vars_to_bzl_vars_version),
    type = "zip",
    url = "https://github.com/SrodriguezO/env_vars_to_bzl_vars/archive/{}.zip".format(env_vars_to_bzl_vars_version),
)

load("@env_vars_to_bzl_vars//:env_vars_loader.bzl", "load_env_vars")

load_env_vars(
    name = "env_vars",
    env_vars = ["COMPILER_CLI_ARTIFACT_ID"],
)
####################################################################

## For tests
play_version = "2.7"  # This doesn't actually matter, since we're not using the default compilers rules_play_routes provides

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
