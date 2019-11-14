#!/bin/bash

rm -rf /home/exam/*

dirArray=(Desktop
Documents
Downloads
Music
Pictures
Public
Templates
Videos)

for i in "${dirArray[@]}"
do
        mkdir /home/exam/$i
        chown -R exam:exam /home/exam/$i
done
