#!/bin/bash
[ -f polya.zip ] && rm polya.zip
mkdir polya
cp $(git ls-files) example.mat polya/
zip -r polya.zip polya
rm -r polya
