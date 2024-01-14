#!/bin/sh

pushd ~/blosxom/posts/___Carnet
find ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/___Carnet -name "*.txt" -exec ln -f -v {} . \;
popd



