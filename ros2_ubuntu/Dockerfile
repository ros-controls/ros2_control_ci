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
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Setup keys
RUN set -eux; \
       key='C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654'; \
       export GNUPGHOME="$(mktemp -d)"; \
       gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; \
       mkdir -p /usr/share/keyrings; \
       gpg --batch --export "$key" > /usr/share/keyrings/ros2-latest-archive-keyring.gpg; \
       gpgconf --kill all; \
       rm -rf "$GNUPGHOME"

# Setup sources.list
RUN echo "deb [ signed-by=/usr/share/keyrings/ros2-latest-archive-keyring.gpg ] http://packages.ros.org/ros2${ROS_REPO_PACKAGES}/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list
# Setup environment
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

ENV ROS_DISTRO=${ROS_DISTRO}
ENV FROM=${FROM}

# Install ROS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
ros-${ROS_DISTRO}-ros-base \
&& rm -rf /var/lib/apt/lists/*

# install dependencies, which ros-tooling/setup-ros would install, see
# https://github.com/ros-tooling/setup-ros/blob/master/src/package_manager/apt.ts
COPY install-packages.sh /tmp/
RUN /tmp/install-packages.sh ${FROM}

# Setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

# setup github labels
LABEL org.opencontainers.image.source=https://github.com/ros-controls/ros2_control_ci
LABEL org.opencontainers.image.description="${FROM}/${ROS_DISTRO} for ros-controls"
LABEL org.opencontainers.image.licenses=Apache-2.0
