#!/bin/bash
cd -- "$(dirname -- "$BASH_SOURCE")"

search_dir="./"
entries=("$search_dir"/*)
> 00_user_files_select.sql
for entry in "$search_dir"/*
do
echo "select * from file ('"$entry"')" | sed 's|.//||g'
if [ "${entry: -4}" ==  ".csv" ]
then
        read -r line < $entry
        echo "select * from file ('"$entry"', CSV)" | sed 's|.//||g' >> 00_user_files_select.sql
        echo "select * from file ('"$entry"', CSV, '${line//,/ String,} String')" | sed 's|.//||g' | sed 's/"//g' >> 00_user_files_select.sql
        echo >> 00_user_files_select.sql
else
        echo "select * from file ('"$entry"')" | sed 's|.//||g' >> 00_user_files_select.sql
        echo >> 00_user_files_select.sql
fi
done