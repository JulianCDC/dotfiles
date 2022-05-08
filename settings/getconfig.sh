#!/bin/sh

value=`yq .$1 ~/.settings/config.yaml | envsubst`

echo $value
