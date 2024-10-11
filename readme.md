# docker-qt

## _qt in docker_

You can use this image to build your qt project in docker.

## Features

- Build image in docker with qt, no need to install qt (and all dependencies) on your host
- Easy to use with CMakefile and Makefile

## Build status

| Qt version | Distro | version | image tag | Status |
| :------: | :------: | :------: | :------: | :------: |
| 6.8.0 | ubuntu | 24.04 | docker.io/bensuperpc/qt:ubuntu-24.04-6.7.2 | WIP |
| 6.7.2 | debian | bookworm | docker.io/bensuperpc/qt:debian-bookworm-6.7.2 | OK |
| 6.6.3 | debian | bookworm | docker.io/bensuperpc/qt:debian-bookworm-6.6.3 | OK |
| 6.5.3 | debian | bookworm | docker.io/bensuperpc/qt:debian-bookworm-6.5.3 | OK |
| 6.6.3 | debian | bullseye | docker.io/bensuperpc/qt:debian-bullseye-6.6.3 | OK |
| 6.5.3 | debian | bullseye | docker.io/bensuperpc/qt:debian-bullseye-6.5.3 | OK |

## Requirements

| Component | Min | Recommanded |
| ------ | ------ | ------ |
| CPU | 2 cores | 8 cores |
| RAM | 16 GB | 32 GB |
| GPU | CLI | CLI |
| Disk space | HDD 25 GB | SSD 70 GB |
| Internet | 10 Mbps | 100 Mbps |
| OS | Linux | Linux |
| Docker | - | - |

### Tested on

With this configuration, you can build qt in 40min (2h30 whith webengine etc...):

- AMD Ryzen 7 5700x (8 cores/16 threads at 3.4 GHz/4.6 GHz)
- 32 GB RAM DDR4 3200 MHz
- Gigabyte B450 Aorus Elite V2
- Nvidia RTX 3060 Ti 8 GB KFA2
- 2*2 TB SSD NVMe Samsung 970 Evo plus (PCIe 3.0 x4 and x2)
- 100 Mbps internet
- Manjaro Linux
- qt 6.7.1 (06/2024)

## How to use docker-qt

Clone this repository

```bash
git clone https://github.com/bensuperpc/docker-qt.git
```

## Build image

The table below shows the available debian versions.
buster bullseye bookworm:

| Debian | Makefile target | Status |
| ------ | ------ | ------ |
| Bookworm | bookworm | OK |
| bullseye | bullseye | OK |
| buster | buster | WIP |

```bash
make bookworm.test
```

### Makefile options

| Option | Default | Description |
| ------ | ------ | ------ |
| QT_VERSION | 6.7.1 | Qt version (Based of IMAGE_VERSION) |
| AUTHOR | bensuperpc | Author name and 1st part of docker image name |
| PROJECT_NAME | qt | Project name and 2nd part of docker image name |


### Start the container

Now you can start the container, it will mount the current directory in the container.

```bash
make bookworm.run
```

## Update submodules and base debian image

```bash
make update
```

## Useful links

- [Docker](https://www.docker.com/)
- [Qt](https://www.qt.io/)
- [Qt documentation](https://doc.qt.io/)

## License

MIT
