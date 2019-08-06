#!/usr/bin/env bash
# Borrowed from lucidsoftware/rules_play_routes

set -e

bazel test //test:play-routes-compiler-test
