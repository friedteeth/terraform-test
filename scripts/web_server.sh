#!/bin/bash
# Samll webserver example

echo "<h1>Hello world!</h1>" > index.html
echo "<h1>This is my mini webpage!</h1>" >> index.html
nohup busybox httpd -f -p 8080 &