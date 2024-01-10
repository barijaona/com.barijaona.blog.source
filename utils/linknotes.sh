#!/bin/sh

pushd ~/blosxom/posts/___Notes
find ~/Nextcloud/Documents/___Notes -name "*.txt" -exec ln -v {} . \;
popd



