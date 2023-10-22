#!/bin/bash

pwd="$PWD"

home_dir="$HOME"

## Update files in home directory
#for file in $(ls -A $pwd); do
#    # check if file exists in home directory
#    if [ -f "$home_dir/$file" ]; then
#            echo "Updating $file"
#            cp -rf $home_dir/$file $pwd
#    fi
#done

# Update files in .config directory
for file in $(ls -A $pwd/.config); do
    echo $file
    # check if file or directory exists in .config directory
    if [ -d "$home_dir/.config/$file" ] || [ -f "$home_dir/.config/$file" ]; then
            echo "Updating .config/$file"
            # copy file or directory to .config directory
            cp -rf $home_dir/.config/$file $pwd/.config
            #cp -rf $home_dir/.config/$file $pwd/.config
    fi
done
