#!/bin/sh

containers=$(docker ps -aq)
[ $containers ] && docker stop $containers
