#!/bin/sh

if [ -f "dist/luambda.zip" ]; then
	rm dist/luambda.zip
fi

if [ ! -d "dist" ]; then
	mkdir dist
fi

zip dist/luambda.zip bootstrap runtime/**