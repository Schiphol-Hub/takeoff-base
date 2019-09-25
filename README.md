<h2 align="center">Schiphol Takeoff Base Docker Image</h2>

<img align="center">
<p align="center">
<a href="https://circleci.com/gh/Schiphol-Hub/takeoff-base/tree/master"><img alt="pipeline status" src="https://img.shields.io/circleci/build/gh/Schiphol-Hub/takeoff-base/master"/></a>
<a href="https://hub.docker.com/r/schipholhub/takeoff-base"><img alt="docker pulls" src="https://img.shields.io/docker/pulls/schipholhub/takeoff-base.svg"></a>
</p>

Base docker image for Schiphol Takeoff to reduce build time. This image contains:

- Java 8u212_1
- SBT 1.2.8
- Scala 2.13.0
- Python 3.7
- Docker 
- Kubectl 1.16.0

Additionally it contains a bunch of python dependencies Schiphol Takeoff relies on, these are specified in `requirements.txt`. The `requirements.txt` mirrors depedencies in [Takeoff setup.py](https://github.com/Schiphol-Hub/takeoff/blob/master/setup.py), if depedencies need to be updated or added it is advised to do in both places.

This image is not meant to be used directly but if you so choose to building is easy:

```bash
docker build -t takeoff-base:local .
```
