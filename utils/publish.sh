#!/bin/sh
rsync -vaz --size-only \
  --exclude=.DS_Store --exclude=.FBCIndex --exclude=.FBCLockFolder --exclude=myPictures --exclude=^\.FBC.*\
  --exclude=200*\
  --stats --progress ~/Sites/ /Volumes/barijaona/Sites/

