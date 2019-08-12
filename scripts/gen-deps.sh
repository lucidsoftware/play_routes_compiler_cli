#!/bin/sh -e
cd "$(dirname "$0")"

bazel run @unpinned_play_routes_compiler_cli_maven//:pin
bazel run @unpinned_play_routes_compiler_cli_test_maven//:pin
