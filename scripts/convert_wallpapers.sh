#!/bin/sh

wallpapers_directory=`~/.settings/getconfig.sh wallpapers.lockscreen`
converted_directory=`~/.settings/getconfig.sh wallpapers.lockscreen_converted`

echo "Found wallpapers in $wallpapers_directory"
echo "Converted wallpapers will be saved in $converted_directory"

# get file names without extensions in converted_directory
old_files_names=`find $converted_directory -type f -name "*.png" | sed 's/.*\/\(.*\)\..*/\1/'`

new_files_paths=`ls $wallpapers_directory`

# get new files names without extensions
new_files_names=`find $wallpapers_directory -type f -name "*" | sed 's/.*\/\(.*\)\..*/\1/'`

echo "Removing old files"

# remove old files not present in new files
for old_file_name in $old_files_names; do
    if ! echo $new_files_names | grep -q $old_file_name; then
        echo "Removing $old_file_name"

        rm $converted_directory/$old_file_name.png
    fi
done

echo "Converting new files"

# convert new wallpapers to png and put them in converted_directory
for new_file_path in $new_files_paths; do
    new_file_name=`echo $new_file_path | sed 's/\(.*\)\..*/\1/'`
    if ! echo $old_files_names | grep -q $new_file_name; then
        echo "Converting $new_file_path"

        convert -scale 1920x1080 $wallpapers_directory/$new_file_path -quality 100 $converted_directory/$new_file_name.png
    fi
done

echo "Finished converting wallpapers"
