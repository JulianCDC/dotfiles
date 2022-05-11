#!/bin/sh

value=`yq .$1 ~/.settings/config.yaml | envsubst`

value2=${value#"\""}
value2=${value2%"\""}

echo $value2
