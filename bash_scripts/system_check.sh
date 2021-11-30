#!/bin/bash

echo Basic System Info:
echo OS: $(grep PRETTY_NAME /etc/os-release | cut -d = -f2-)
echo CPU: $(grep 'model name' /proc/cpuinfo -m 1 | cut -d" " -f3-)

