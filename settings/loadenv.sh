#!/bin/bash

env_keys=`yq .env ~/.settings/config.yaml | yq 'keys[]'`

for key in $env_keys; do
    value=`yq .env.$key ~/.settings/config.yaml`

    formated_value=${value#"\""}
    formated_value=${formated_value%"\""}

    variable_name=`echo $key | tr '[:lower:]' '[:upper:]'`

    formated_variable_name=${variable_name#"\""}
    formated_variable_name=${formated_variable_name%"\""}

    export $formated_variable_name="$formated_value"

    unset key
    unset value
    unset formated_value
    unset variable_name
    unset formated_variable_name
done

unset env_keys
