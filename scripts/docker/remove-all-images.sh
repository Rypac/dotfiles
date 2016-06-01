#!/bin/sh

images=$(docker images -aq)
[ "$images" ] && docker rmi -f $images
