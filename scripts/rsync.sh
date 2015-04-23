#!/usr/bin/env bash

set -x 

SERVER_HOST=ralch.com
SERVER_USERNAME=vcap
SERVER_DESTINATION_DIR=/var/vcap/jobs/
OUTPUT_DIR=../ralch-blog

echo "-- Building blog.ralch.com"

mkdir -p $OUTPUT_DIR

hugo -D -v -s ../web -d $OUTPUT_DIR

cp dockit.sh $OUTPUT_DIR

echo "-- Rsync to $SERVER_HOST"

rsync -az --force --progress -e "ssh" $OUTPUT_DIR $SERVER_USERNAME@$SERVER_HOST:$SERVER_DESTINATION_DIR

echo "-- Cleaning up"

rm -fr $OUTPUT_DIR

