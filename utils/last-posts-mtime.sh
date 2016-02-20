#!/bin/sh
find ~/blosxom/posts -type f \! -name ".DS_Store" -print0 | xargs -0 stat -l -t '%Y%m%d%H%M.%S' | awk '{print $6, $7}' | sort -nr | head -n 20 | xargs -L 1 echo touch -t 