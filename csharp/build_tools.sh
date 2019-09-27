#!/bin/bash

if [ $# -ne 1 ]; then
  cat <<EOF
Usage: $0 <VERSION_NUMBER>

Example:
  $ $0 3.0.0

This script will download pre-built protoc binaries from maven repository and
create the Google.Protobuf.Tools package. Well-known type .proto files will also
be included.
EOF
  exit 1
fi

VERSION_NUMBER=$1
# <directory name> <binary file name> pairs.
declare -a FILE_NAMES=(          \
  win32       win32.zip          \
  win64       win64.zip          \
  osx-32      osx-x86_32.zip     \
  osx-64      osx-x86_64.zip     \
  linux_32    linux-x86_32.zip   \
  linux_64    linux-x86_64.zip   \
)

set -e

mkdir -p protoc
# Create a zip file for each binary.
for((i=0;i<${#FILE_NAMES[@]};i+=2));do
  DIR_NAME=${FILE_NAMES[$i]}
  mkdir -p protoc/$DIR_NAME

  BINARY_NAME=${FILE_NAMES[$(($i+1))]}
  BINARY_URL=https://github.com/protocolbuffers/protobuf/releases/download/v${VERSION_NUMBER}/protoc-${VERSION_NUMBER}-${BINARY_NAME}

  if ! wget ${BINARY_URL} -O protoc/$DIR_NAME/protoc.zip; unzip protoc/$DIR_NAME/protoc.zip; then
    echo "[ERROR] Failed to download ${BINARY_URL}" >&2
    echo "[ERROR] Skipped $protoc-${VERSION_NAME}-${DIR_NAME}" >&2
    continue

    cd /protoc/$DIR_NAME unzip
    cd ../../
  fi
done





#nuget pack Google.Protobuf.Tools.nuspec