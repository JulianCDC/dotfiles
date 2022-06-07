#!/bin/sh

main_keys=`yq . ~/.settings/meta.yaml | yq 'keys[]'`

if [ ! -f ~/.settings/config.yaml ]; then
    echo "Creating config.yaml"
    touch ~/.settings/config.yaml

    echo "{}" > ~/.settings/config.yaml
fi

for key in $main_keys; do
    config_keys=`yq .$key ~/.settings/meta.yaml | yq 'keys[]'`

    for config_key in $config_keys; do
        value=`yq .$key.$config_key ~/.settings/meta.yaml`

        label=`echo $value | yq .label`
        default=`echo $value | yq .default`

        formated_label=${label#"\""}
        formated_label=${formated_label%"\""}

        echo "$formated_label (default: $default):"

        read config_value

        if [ -z "$config_value" ]; then
            config_value=$default
        fi

        yq -i -y ".$key.$config_key = $config_value" ~/.settings/config.yaml
    done
done

echo "Finished writing config in ~/.settings/config.yaml"
