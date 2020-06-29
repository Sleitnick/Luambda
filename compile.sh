if [ ! -d dist ]; then
	mkdir dist
fi
if [ ! -d dist/runtime ]; then
	mkdir dist/runtime
fi

for f in src/*.lua; do
	#luajit -b $f dist/runtime/`basename $f .lua`.out
	cp $f dist/runtime/`basename $f`
done