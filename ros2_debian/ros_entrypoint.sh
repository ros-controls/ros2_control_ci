#!/bin/bash
set -e

# setup ros2 environment
source "/opt/ros2_ws/install/setup.bash"
exec "$@"
