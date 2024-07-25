#!/usr/bin/env sh

if [ "$1" != check ]; then
    bazel run buildifier
else
    bazel run buildifier_test
fi