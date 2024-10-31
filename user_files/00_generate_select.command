#!/bin/bash
cd -- "$(dirname -- "$BASH_SOURCE")"

search_dir="./"
> 00_user_files_select.sql
for entry in "$search_dir"/*
do
if [ "${entry: -4}" ==  ".csv" ];
then
        read -r line < "$entry"
        echo "SELECT * FROM file ('"$entry"', CSV)" | sed 's|.//||g' >> 00_user_files_select.sql
        echo "SELECT * FROM file ('"$entry"', CSV, '\"${line//,/\" String,\"}\" String')" | sed 's|.//||g' | sed 's/""/"/g'  >> 00_user_files_select.sql
        echo >> 00_user_files_select.sql
        echo "SELECT * FROM file ('"$entry"')" | sed 's|.//||g'
elif [ "${entry: -4}" !=  ".sql" ] && [ "${entry: -8}" !=  ".command" ];
	then
        echo "SELECT * FROM file ('"$entry"')" | sed 's|.//||g' >> 00_user_files_select.sql
        echo >> 00_user_files_select.sql
        echo "SELECT * FROM file ('"$entry"')" | sed 's|.//||g'
fi
done
