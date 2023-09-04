# amcl3d

Original repository: https://github.com/fada-catec/amcl3d

## Build
```bash
cd amcl3d/docker
./build.sh
```

## Run

### On docker image
```bash
cd amcl3d/docker
./run.sh

# roslaunch fast_livo mapping_avia.launch
```

### On host

```bash
cd FAST_LIVO/rviz_cfg
rviz -d loam_livox.rviz
```

```bash
rosbag play hku1.bag
```

![ezgif com-gif-maker](https://user-images.githubusercontent.com/31344317/213341608-d5443ae7-a151-4731-ac34-959dc5c4654b.gif)
