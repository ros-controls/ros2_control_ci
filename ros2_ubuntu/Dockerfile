# Copyright 2024 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


ARG FROM=ubuntu:noble
FROM ${FROM}

ARG ROS_DISTRO=rolling
ARG ROS_REPO_PACKAGES=""

# Setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    software-properties-common \
    dirmngr \
    gnupg2 \
    lsb-release \
    curl \
    && add-apt-repository universe \
    && rm -rf /var/lib/apt/lists/*

# Setup keys
RUN set -eux; \
    ROS_APT_SOURCE_VERSION="$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')" ; \
    if [ -z "$ROS_APT_SOURCE_VERSION" ]; then \
      echo "Failed to fetch ROS_APT_SOURCE_VERSION" >&2; \
      exit 1; \
    fi ; \
    ROS_APT_PACKAGE="https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2${ROS_REPO_PACKAGES}-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $UBUNTU_CODENAME)_all.deb" ; \
    echo "Downloading and installing ROS apt source package: ${ROS_APT_PACKAGE}" ; \
    curl -fL -o /tmp/ros2-apt-source.deb "${ROS_APT_PACKAGE}" ; \
    if [ ! -s /tmp/ros2-apt-source.deb ]; then \
      echo "Downloaded .deb file is missing or empty" >&2; \
      exit 1; \
    fi ; \
    dpkg-deb -I /tmp/ros2-apt-source.deb > /dev/null || { echo "Invalid .deb file"; exit 1; } ; \
    apt-get install -y /tmp/ros2-apt-source.deb ; \
    rm /tmp/ros2-apt-source.deb

# Setup environment
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV ROS_DISTRO=${ROS_DISTRO}

# Install ROS packages and dev dependencies, which ros-tooling/setup-ros would install see
# https://github.com/ros-tooling/setup-ros/blob/master/src/package_manager/apt.ts
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-${ROS_DISTRO}-ros-base \
    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
    $(if [ $(lsb_release -sc) = "noble" ]; then echo "libssl-dev python3-dev clang lcov python3-rosinstall-generator python3-pip python3-pytest-cov python3-flake8-blind-except python3-flake8-class-newline python3-flake8-deprecated python3-pytest-repeat python3-pytest-rerunfailures ros-dev-tools python3-colcon-coveragepy-result python3-colcon-lcov-result python3-colcon-meson python3-colcon-mixin python3-importlib-metadata libclang-rt-dev"; fi) \
    $(if [ $(lsb_release -sc) = "jammy" ]; then echo "libssl-dev python3-dev clang lcov python3-rosinstall-generator python3-flake8-docstrings python3-pip python3-pytest-cov python3-flake8-blind-except python3-flake8-builtins python3-flake8-class-newline python3-flake8-comprehensions python3-flake8-deprecated python3-flake8-import-order python3-flake8-quotes python3-pytest-repeat python3-pytest-rerunfailures ros-dev-tools python3-colcon-coveragepy-result python3-colcon-lcov-result python3-colcon-meson python3-colcon-mixin libasio-dev libtinyxml2-dev"; fi) \
    && rm -rf /var/lib/apt/lists/*

# Bootstrap rosdep
RUN rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO

# Setup entrypoint (sourcing of ROS)
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

# setup github labels
LABEL org.opencontainers.image.source=https://github.com/ros-controls/ros2_control_ci
LABEL org.opencontainers.image.description="Container with preinstalled ROS for ros-controls CI"
LABEL org.opencontainers.image.licenses=Apache-2.0
