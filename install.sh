#!/bin/bash

# Source directory
src_dir="$PWD"

# Destination directory
dest_dir="$HOME"

# Exclude files
exclude_files=(.git .gitignore .gitmodules install.sh README.md LICENSE .config .DS_Store)

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
