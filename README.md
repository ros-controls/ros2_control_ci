# ros2_control_ci

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This repository holds reusable workflows for CI of the ros2_control framework as well as docker images for building the ros2_control stack on different platforms.

It also builds the full ros2_control stack once per day.

## Released versions

[![Rolling Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-binary-build.yml)

[![Jazzy Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/jazzy-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/jazzy-binary-build.yml)

[![Humble Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/humble-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/humble-binary-build.yml)

## Compatibility versions
We thrive to make the rolling development version of the ros2_control stack compatible with earlier releases of ROS2. This is done by building the rolling version of the stack from source with the earlier releases of ROS2.

[![Check Rolling Compatibility on Jazzy with Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-jazzy-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-jazzy-binary-build.yml)

[![Check Rolling Compatibility on Humble with Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-humble-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-humble-binary-build.yml)

## ros2_rhel
This is a sample Dockerfile that show ros2 installed on almalinux based on the [binary installation instructions at docs.ros.org](https://docs.ros.org/en/rolling/Installation/RHEL-Install-RPMs.html). The most recent public build can be found with the docker tag: `ghcr.io/ros-controls/ros:<ROS_DISTRO>-rhel` where `<ROS_DISTRO>` is replaced with the ros distribution you are targeting.

The image tries to emulate the official ros2 images but on alma (downstream RHEL) linux. Therefore a few extra packages can be found within this repo that are not mentioned at the above link, i.e. colcon, etc.

Only supports galactic and later releases as that is what the [ros2 buildfarm supports for RHEL](https://ros.org/reps/rep-2000.html#galactic-geochelone-may-2021-november-2022).

## ros2_debian

The purpose of this repository is to provide docker images for building ros2_control on debian.
They are automatically built and pushed to https://github.com/ros-controls/ros2_rhel/pkgs/container/ros

Pull and run the images with:
```bash
docker pull ghcr.io/ros-controls/ros:rolling-debian
docker run -it ghcr.io/ros-controls/ros:rolling-debian bash
```

To manually build them, you can use the following commands:
```bash
docker build -t ros2_debian11_humble . -f Dockerfile.debian11 --build-arg ROS_DISTRO=humble
docker build -t ros2_debian11_iron . -f Dockerfile.debian11 --build-arg ROS_DISTRO=iron
docker build -t ros2_debian12_jazzy . -f Dockerfile.debian12 --build-arg ROS_DISTRO=jazzy
docker build -t ros2_debian12_rolling . -f Dockerfile.debian12 --build-arg ROS_DISTRO=rolling
```
