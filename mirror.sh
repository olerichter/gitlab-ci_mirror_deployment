#!/bin/bash

fromprojecturl=$CI_PROJECT_URL
fromprojecturl+=".git"

git clone --mirror $fromprojecturl tomirror
cd tomirror

if [[ $MIRROR_LFS == "True" ]]; then
    git lfs fetch --all
fi

git push -q --mirror $MIRROR_GIT_URL > /dev/null 2>&1

if [ $? != 0 ]; then
echo "push to repository failed"
exit 1
else
echo "push to mirror repository done"
fi

if [[ $MIRROR_LFS == "True" ]]; then
git lfs push -q --all $MIRROR_GIT_URL > /dev/null 2>&1
if [ $? != 0 ]; then
echo "lfs push to repository failed"
exit 1
else
echo "lfs push to mirror repository done"
fi
fi

