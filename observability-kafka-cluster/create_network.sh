#!/bin/bash

docker network create -d bridge --subnet=192.168.100.0/24 kafka-net