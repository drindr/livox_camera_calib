FROM josephp97/ros-ceres:melodic_1.14.0

COPY . /root/catkin_ws/src/livox_camera_calib

RUN apt-get update \
    && apt-get install -y ros-melodic-rviz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mv /usr/include/flann/ext/lz4.h /usr/include/flann/ext/lz4.h.bak \
    && mv /usr/include/flann/ext/lz4hc.h /usr/include/flann/ext/lz4hc.h.bak \
    && ln -s /usr/include/lz4.h /usr/include/flann/ext/lz4.h \
    && ln -s /usr/include/lz4hc.h /usr/include/flann/ext/lz4hc.h \
    && mkdir -p /root/catkin_ws/src \
    && cd /root/catkin_ws/src \
    && cd /root/catkin_ws \
    && /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make"

CMD ["/bin/bash", "-c", "source /root/catkin_ws/devel/setup.bash; roslaunch livox_camera_calib calib.launch"]
