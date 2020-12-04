#!/bin/sh

if gcc main.c -o out; then
	exec ./out
fi
