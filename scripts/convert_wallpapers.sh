#!/bin/sh

wallpapers_directory=`getconfig wallpapers.lockscreen`
converted_directory=`getconfig wallpapers.lockscreen_converted`

# get file names without extensions in converted_directory
old_files_names=`find $converted_directory -type f -name "*.png" | sed 's/.*\/\(.*\)\..*/\1/'`

new_files_paths=`ls $wallpapers_directory`

# get new files names without extensions
new_files_names=`echo $new_files | sed 's/\(.*\)\..*/\1/'`

# remove old files not present in new files
for old_file_name in $old_files_names; do
    if ! echo $new_files_names | grep -q $old_file_name; then
        rm $converted_directory/$old_file_name.png
    fi
done

# convert new wallpapers to png and put them in converted_directory
for new_file_path in $new_files_paths; do
    new_file_name=`echo $new_file_path | sed 's/\(.*\)\..*/\1/'`
    if ! echo $old_files_names | grep -q $new_file_name; then
        convert -scale 1920x1080 $wallpapers_directory/$new_file_path -quality 100 $converted_directory/$new_file_name.png
    fi
done
