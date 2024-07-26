#!/usr/bin/env bash
# Borrowed from lucidsoftware/rules_play_routes

set -euxo pipefail

bazel test //test:play-routes-compiler-test
bazel test //test:split-forward-reverse-routes-test
