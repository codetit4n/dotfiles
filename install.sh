#!/bin/bash

# Source directory
src_dir="$PWD"

# Destination directory
dest_dir="$HOME"

# Exclude files
exclude_files=(.git .gitignore .gitmodules install.sh README.md LICENSE .config sync.sh)

# Install files
for file in $(ls -A $src_dir); do
    if [[ ! " ${exclude_files[@]} " =~ " ${file} " ]]; then
        cp -rf $src_dir/$file $dest_dir
        echo "Installed $file"
    fi
done

# Install .config files
for file in $(ls -A $src_dir/.config); do
    # create .config directory if it doesn't exist
    if [ ! -d "$dest_dir/.config" ]; then
        mkdir $dest_dir/.config
        echo "Created .config directory"
    fi
    cp -rf $src_dir/.config/$file $dest_dir/.config
    echo "Installed $file"
done

# chmod +x all files in dest_dir/.config/scripts directory
for file in $(ls -A $dest_dir/.config/scripts); do
    sudo chmod +x $dest_dir/.config/scripts/$file
    echo "chmod +x $file"
done

# chmod +x all files in dest_dir/.config/polybar/scripts directory
for file in $(ls -A $dest_dir/.config/polybar/scripts); do
    sudo chmod +x $dest_dir/.config/polybar/scripts/$file
    echo "chmod +x $file"
done
