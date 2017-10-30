#!/bin/bash
# Check location of the script
script_path="$(greadlink f ${BASH_SOURCE[0]})"
gs_home="$(dirname $script_path)"
cd $gs_home

# Check if there is any configuration file (gitswitch.cfg)
cfg=`ls . | grep gitswitch.cfg | wc -l`

# If NOT, then create new configuration file
if [[ $cfg -eq 0 ]]; then
    echo "You started GitSwitch for the first time."
    echo "Please answer few questions, which will be used for creation of config file."
    echo
        while (true); do
            echo -n "What is name of Dropbox folder, for GitSwitch commands? (i.e. GS_Commands): "
            read gs_dboxstorage
            echo
            echo
            echo "Please check if the information below is correct."
            echo "***************************************************"
            echo "Name of Dropbox folder: $gs_dboxstorage"
            echo
            echo -n "Are these values correct? [y/n]: "
            read answer
                if [[ $answer == y ]]; then
                        break;
                fi
        done
    echo
    echo "Enjoy!"
    echo
    mkdir $gs_dboxstorage
    echo "gs_dboxstorage=$gs_dboxstorage" > gitswitch.cfg
    echo "gs_storage=$gs_home/$gs_dboxstorage" >> gitswitch.cfg
fi

# Load configuration file
. gitswitch.cfg

# Check for new files on Raspberry Pi
check=`ls $gs_storage | wc -l`

if [[ $check -eq 0 ]];
    then exit 0
fi

files=`ls $gs_storage`

# Grant rights for executing of delivered scripts
for i in $files
do
    chmod +x $gs_storage/$i
done

# Run all delivered scripts
for i in $files
do
    $gs_storage/$i > /dev/null 2>&1
done

# Remove all scripts that were already executed
rm $gs_storage/*
