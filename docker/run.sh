#!/bin/bash
docker run --net=host -it --rm \
           --gpus all \
           -e DISPLAY=$DISPLAY \
           -v $HOME/.Xauthority:/root/.Xauthority \
           -v $(realpath ..):/root/catkin_ws/src/FAST_LIO_LOCALIZATION \
           -w /root/catkin_ws/src/FAST_LIO_LOCALIZATION \
           $@ \
           fast_lio_loc
