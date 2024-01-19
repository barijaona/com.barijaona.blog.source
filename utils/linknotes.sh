#!/bin/sh

pushd ~/blosxom/posts/___Carnet
rsync -avH  ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/___Carnet/*.txt  .
popd



