#!/usr/bin/env bash

mkdir -p ${HOME}/.config/pulse
echo load-module module-loopback > ${HOME}/.config/pulse/loopback.pa
pactl load-module module-loopback