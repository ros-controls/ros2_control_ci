# ros2_control_ci

[![Licence](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This repository holds reusable workflows for CI of the ros2_control framework.

It also builds the full ros2_control stack once per day.

## Released versions

[![Rolling Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-binary-build.yml)
[![Iron Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/iron-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/iron-binary-build.yml)
[![Humble Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/humble-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/humble-binary-build.yml)

## Compatibility versions
We thrive to make the rolling development version of the ros2_control stack compatible with earlier releases of ROS2. This is done by building the rolling version of the stack from source with the earlier releases of ROS2.

[![Check Rolling Compatibility on Iron with Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-iron-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-iron-binary-build.yml)
[![Check Rolling Compatibility on Humble with Stack Build](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-humble-binary-build.yml/badge.svg)](https://github.com/ros-controls/ros2_control_ci/actions/workflows/rolling-compatibility-humble-binary-build.yml)
