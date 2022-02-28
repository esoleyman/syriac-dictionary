#!/usr/bin/sh

### Build the dictionary from partial dictionaries


# Create release directory
mkdir -p release

# Check for sorted input. If not sorted, then sort and keep unqiue words
sort -u dict/sureth.dic dict/sedra.dic > release/syr.tmp.dic

# Remove blank lines
sed -i -e '/^$/d' release/syr.tmp.dic

# Add line count
wc -l < release/syr.tmp.dic > release/syr.dic

# Copy the temporary dictionary to the release along with its affix file
cat release/syr.tmp.dic >> release/syr.dic
cat dict/syr.aff > release/syr.aff

# Remove temporary dictionary
rm release/syr.tmp.dic


printf "Build finished. Find files in /release\n"
