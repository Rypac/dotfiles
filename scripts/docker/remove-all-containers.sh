#!/bin/sh

containers=$(docker ps -aq)
[ $containers ] && docker rm -f $containers
