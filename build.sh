#!/usr/bin/bash

set -x
set -e

name=torrent-file-editor

exclude="debug debug-qt4 debug-qt5 release release-qt4 release-qt5 linux linux-qt4 linux-qt5 CMakeLists.txt.user"
exclude=$(echo $exclude | sed  -r 's/[^ ]+/-e &/g')

git clean -dfx . $exclude
mkdir win32
pushd win32
mingw32-cmake .. -DCMAKE_EXE_LINKER_FLAGS=-static -DCMAKE_BUILD_TYPE=Release
make -j5
version=$(cat version)
mv ${name}.exe ../${name}-${version}-x32.exe
popd

mkdir win64
pushd win64
mingw64-cmake .. -DCMAKE_EXE_LINKER_FLAGS=-static -DCMAKE_BUILD_TYPE=Release
make -j5
version=$(cat version)
mv ${name}.exe ../${name}-${version}-x64.exe
popd
