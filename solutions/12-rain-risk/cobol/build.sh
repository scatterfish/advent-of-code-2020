#!/bin/sh

if cobc -free -x -O -o out main.cbl; then
	exec ./out
fi
