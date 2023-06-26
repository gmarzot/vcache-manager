#!/usr/bin/env bash

SOURCE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SOURCE_DIR

if [[ $? != 0 ]]; then
	echo "[$?] unable to cd to source directory..."
	exit 1
fi

mkdir release

GIT_REVISION=$(git describe)

if [[ $? != 0 ]]; then
    echo "[$?] unable to run `git describe`..."
    exit 2
fi

echo -n ${GIT_REVISION} > ./.version
# this will be included in released images
echo -n ${GIT_REVISION} > ./context/node-red/etc/vcache-mgr/vcache.version

cd ..

mv $SOURCE_DIR vcache-mgr-${GIT_REVISION}

./vcache-mgr-${GIT_REVISION}/makeself.sh --sha256 --nox11 --notemp --tar-extra "--exclude=.git --exclude=.gitignore --exclude=make* --exclude=.npm --exclude=release --exclude=*~" --license LICENSE vcache-mgr-${GIT_REVISION} vcache-mgr-${GIT_REVISION}/release/vcache-mgr-${GIT_REVISION}.run "vCache Mnagager Deployment" 

mv vcache-mgr-${GIT_REVISION} $SOURCE_DIR
