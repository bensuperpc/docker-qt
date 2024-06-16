# docker-qt

## _qt in docker_

You can use this image to build your qt project in docker.

## Features

- Build image in docker with qt, no need to install qt (and all dependencies) on your host
- Easy to use (Makefile)

## Requirements

### Software requirements

| Software | Minimum | Recommended |
| ------ | ------ | ------ |
| Linux | Any | Any |
| Docker | 19.x | 20.x |
| Make | 4.x | 4.x |
| Time | x hours | x hours |

### Hardware requirements

| Hardware | Minimum | Recommended |
| ------ | ------ | ------ |
| CPU | 2 cores | 8 cores |
| GPU | - | - |
| Disk space | HDD 50 GB | SSD 100 GB |
| Internet | 10 Mbps | 100 Mbps |

### Tested on

With this configuration, you can build qt in 40min (2h30 whith webengine etc...):

- AMD Ryzen 7 5700x (8 cores/16 threads at 3.4 GHz/4.6 GHz)
- 32 GB RAM DDR4 3200 MHz
- 2*2 TB SSD NVMe Samsung 970 Evo plus (PCIe 3.0 x4 and x2)
- Nvidia RTX 3060 Ti
- 100 Mbps internet
- Manjaro Linux
- qt 6.7.1 (06/2024)

## How to use docker-qt

Clone this repository

```bash
git clone https://github.com/bensuperpc/docker-qt.git
```

## Build image

```bash
make build
```

### Start the container

Now you can start the container, it will mount the current directory in the container.

```bash
make bookworm.run
```

The table below shows the available debian versions.
buster bullseye bookworm:

| Debian | Makefile target |
| ------ | ------ |
| Bookworm | bookworm |
| bullseye | bullseye |
| buster | buster |

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
