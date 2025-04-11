#!/bin/bash
set -eux
apt-get update && apt-get install -y --no-install-recommends \
$(if [ "$1" = "ubuntu:noble" ]; then echo "libssl-dev python3-dev clang lcov python3-rosinstall-generator python3-pip python3-pytest-cov python3-flake8-blind-except python3-flake8-class-newline python3-flake8-deprecated python3-pytest-repeat python3-pytest-rerunfailures ros-dev-tools python3-colcon-coveragepy-result python3-colcon-lcov-result python3-colcon-meson python3-colcon-mixin python3-importlib-metadata libclang-rt-dev"; fi) \
$(if [ "$1" = "ubuntu:jammy" ]; then echo "libssl-dev python3-dev clang lcov python3-rosinstall-generator python3-flake8-docstrings python3-pip python3-pytest-cov python3-flake8-blind-except python3-flake8-builtins python3-flake8-class-newline python3-flake8-comprehensions python3-flake8-deprecated python3-flake8-import-order python3-flake8-quotes python3-pytest-repeat python3-pytest-rerunfailures ros-dev-tools python3-colcon-coveragepy-result python3-colcon-lcov-result python3-colcon-meson python3-colcon-mixin libasio-dev libtinyxml2-dev"; fi) \
&& rm -rf /var/lib/apt/lists/*
