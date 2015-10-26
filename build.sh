#!/usr/bin/env bash

build_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

(cd "${build_dir}" && exec docker build -t saiban/space-engineers .)
