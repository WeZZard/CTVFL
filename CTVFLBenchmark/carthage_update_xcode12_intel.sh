#!/bin/sh

export XCODE_XCCONFIG_FILE=$PWD/carthage-xcode12-intel.xcconfig

carthage update --platform iOS --no-use-binaries --cache-builds

