#!/usr/bin/sh

### 
# Build the dictionary from partial dictionaries
###

basedir="${PWD}"

### HUNSPELL 

# Create release directory
mkdir -p "$basedir/release"

# Check for sorted input. If not sorted, then sort and keep unqiue words
sort -u "$basedir/dict/sureth.dic" "$basedir/dict/sedra.dic" > "$basedir/release/syr.tmp.dic"

# Remove blank lines
sed -i -e '/^$/d' "$basedir/release/syr.tmp.dic"

# Add line count
wc -l < "$basedir/release/syr.tmp.dic" > "$basedir/release/syr_SY.dic"

# Copy the temporary dictionary to the release along with its affix file
cat "$basedir/release/syr.tmp.dic" >> "$basedir/release/syr_SY.dic"
cat "$basedir/dict/syr.aff" > "$basedir/release/syr_SY.aff"

# Remove temporary dictionary
rm "$basedir/release/syr.tmp.dic"


### Libreoffice

# Copy files from release above
cp "$basedir/release/syr_SY.dic" "$basedir/templates/libreoffice/"
cp "$basedir/release/syr_SY.aff" "$basedir/templates/libreoffice/"

# Create zip package
cd templates/libreoffice && zip -qr dict_syr_SY.oxt ./*
mv "$basedir/templates/libreoffice/dict_syr_SY.oxt" "$basedir/release/"

# Remove dictionary files from libreoffice
rm "$basedir/templates/libreoffice/syr_SY.dic"
rm "$basedir/templates/libreoffice/syr_SY.aff"


printf "Build finished. Find files in /release\n"
