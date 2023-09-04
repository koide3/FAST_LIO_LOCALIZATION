FROM ros:noetic

# Install apt-fast
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install --no-install-recommends -y software-properties-common gnupg ca-certificates \
  && add-apt-repository ppa:apt-fast/stable \
  && apt-get update \
  && apt-get install --no-install-recommends -y apt-fast \
  && apt-fast clean \
  && rm -rf /var/lib/apt/lists/*

RUN echo debconf apt-fast/maxdownloads string 16 | debconf-set-selections && \
  echo debconf apt-fast/dlflag boolean true | debconf-set-selections && \
  echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections

RUN apt-fast update \
  && apt-fast install -y --no-install-recommends \
  git wget nano libomp-dev build-essential python3-pip

RUN apt-fast install -y --no-install-recommends \
  ros-${ROS_DISTRO}-eigen-conversions \
  ros-${ROS_DISTRO}-pcl-ros ros-${ROS_DISTRO}-rviz \
  ros-${ROS_DISTRO}-tf2-geometry-msgs \
  ros-${ROS_DISTRO}-tf2-sensor-msgs \
  ros-${ROS_DISTRO}-diagnostic-updater \
  ros-${ROS_DISTRO}-roslint \
  ros-${ROS_DISTRO}-topic-tools

# && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN git clone https://github.com/Livox-SDK/Livox-SDK.git

WORKDIR /root/Livox-SDK/build
RUN cmake .. && make -j$(nproc) install


RUN apt-fast install -y --no-install-recommends \
  ros-${ROS_DISTRO}-ros-numpy
RUN pip install pyrsistent==0.15
RUN pip install open3d==0.10

RUN apt-fast install -y --no-install-recommends \
  python-is-python3

RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws/src

RUN git clone https://github.com/Livox-SDK/livox_ros_driver.git
COPY . /root/catkin_ws/src/FAST_LIO_LOCALIZATION

WORKDIR /root/catkin_ws
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash; catkin_make -DCMAKE_BUILD_TYPE=Release'

RUN sed -i "6i source \"/root/catkin_ws/devel/setup.bash\"" /ros_entrypoint.sh

WORKDIR /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
