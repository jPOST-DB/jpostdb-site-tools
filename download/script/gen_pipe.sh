#!/bin/sh
mkfifo $1
cd ./files/$3/
tar -cvf $1 ./$2/*
