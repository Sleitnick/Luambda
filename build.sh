#!/bin/sh

./compile.sh

cp lua/luajit dist/runtime/luajit
chmod +x dist/runtime/luajit
chmod +x src/bootstrap

if [ -f "dist/luambda.zip" ]; then
	rm dist/luambda.zip
fi

if [ ! -d "dist" ]; then
	mkdir dist
fi

cd src
zip ../dist/luambda.zip bootstrap
cd ../dist
zip luambda.zip runtime/**