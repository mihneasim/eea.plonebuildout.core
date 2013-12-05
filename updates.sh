#!/bin/bash

# Update step 1: Update *.tpl-s used by template recipes

TMP_CHECKOUT="/tmp/eea.plonebuildout.core"
git clone https://github.com/eea/eea.plonebuildout.core.git $TMP_CHECKOUT
mkdir -p ./buildout-configs/templates
rm -rf ./buildout-configs/templates && \
    cp -r $TMP_CHECKOUT/buildout-configs/templates ./buildout-configs/
rm -rf $TMP_CHECKOUT

# Update step 2: Store and inform revision via Zope Environment var in buildout

json=$(curl https://api.github.com/repos/eea/eea.plonebuildout.core/commits/HEAD 2> /dev/null)
open=0
buffer=""
for (( i=0; i<${#json}; i++ )); do
    char=${json:$i:1}
    if [ "$char" = "{" ]; then
        open=$(( $open+1 ))
        testdone=$( echo $buffer | grep '"sha":"[a-f0-9]\+"' )
        if [ -n "$testdone" ]; then
            break
        fi
    elif [ "$char" = "}" ]; then
        open=$(( $open-1 ))
        testdone=$( echo $buffer | grep '"sha":"[a-f0-9]\+"' )
        if [ -n "$testdone" ]; then
            break
        fi
    elif [ "$open" = "1" ]; then
        if [ "$char" != $'\n' -a "$char" != " " ]; then
            buffer="$buffer$char"
        fi
    fi
done

LATEST=$( echo $buffer | sed 's/"sha":"\([a-f0-9]\+\)".*/\1/' )
if [ -z "$LATEST" ]; then
    echo "Fatal: Can not read last revision of eea.plonebuildout.core"
    return 1
fi

ENV_VAR_NAME="CURRENT_CORE_VERSION"

for cfg in "development.cfg" "deployment.cfg"; do
    echo "Tagging current revision of eea.plonebuildout.core in $cfg"
    existing_pin=$(grep $ENV_VAR_NAME $cfg)
    if [ -n "$existing_pin" ]; then
        # env var exists in configuration
        sed -i "s/^ *$ENV_VAR_NAME.*\$/    $ENV_VAR_NAME $LATEST/" $cfg
    else
        # env var does not exist in configuration
        existing_directive=$(grep zeoclient-environment-vars $cfg)
        if [ -n "$existing_directive" ]; then
            sed -i "s/^ *#\?zeoclient-environment-vars.*\$/zeoclient-environment-vars =\n    $ENV_VAR_NAME $LATEST/" $cfg
        else
            # section does not exist in configuration
            sed -i "s/^\[configuration\].*\$/[configuration]\nzeoclient-environment-vars =\n    $ENV_VAR_NAME $LATEST/" $cfg
        fi
    fi
    echo "Done"

done
