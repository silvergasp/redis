#!/bin/bash
set -euo pipefail

GIT_SHA1=`(git show-ref --head --hash=8 2> /dev/null || echo 00000000) | head -n1`
GIT_DIRTY=`git diff --no-ext-diff 2> /dev/null | wc -l`
BUILD_ID=`uname -n`"-"`date +%s`

echo "STABLE_GIT_SHA1 $GIT_SHA1"
echo "GIT_DIRTY $GIT_DIRTY"
echo "BUILD_ID $BUILD_ID"