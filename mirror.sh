#!/bin/bash

fromprojecturl = $CI_PROJECT_URL
fromprojecturl +=".git"

git clone --mirror $fromprojecturl tomirror
cd tomirror

if [ $MIRROR_LFS = "True" ]; then
    git lfs fetch --all
fi

git push --mirror $MIRROR_GIT_URL > /dev/null 2>&1

if [ $MIRROR_LFS = "True" ]; then
    git lfs push --all $MIRROR_GIT_URL > /dev/null 2>&1
fi
