#!/usr/bin/python3

#
# Take the output from the syriacdb database, remove the diacritics from each word, and output a list of words
# to use in any fashion.
#

import psycopg2
import unicodedata
import re
import numpy

syriac_unicode = set(range(0x0700, 0x074F))

connect = psycopg2.connect(database="[database]", user="[user]", password="[password]", host="127.0.0.1", port="5432")

cursor = connect.cursor()

statement = ("SELECT DISTINCT syriac_east FROM assyrianlanguages ORDER BY syriac_east")

cursor.execute(statement)

# Initialize set
set_of_words = set()

words = cursor.fetchall()
for word in words:

    ### Strip diacritics

    # Decompose the unicode characters into their respective parts
    nfkd_form = unicodedata.normalize('NFKD', str(word))

    # Strip the diacritics
    keep_chars = "".join([c for c in nfkd_form if not (ord(c) in syriac_unicode and unicodedata.combining(c))])
    #
    # Compose the unicode characters
    normalized = unicodedata.normalize('NFKC', str(keep_chars))

    ### Don't strip diacritics
    # normalized = str(word)

    # Perform post-processing
    normalized = re.sub('[()]', '', normalized) # Remove parentheses
    normalized = normalized.replace('\'','')    # Remove single quote
    normalized = normalized.replace(',','')     # Remove comma
    normalized = normalized.replace('.','')     # Remove dot
    normalized = normalized.replace(' ','')     # Remove blank spaces
    normalized = normalized.replace('-','')     # Remove dash
    normalized = normalized.replace('!','')     # Remove exclamation
    normalized = normalized.replace('?','')     # Remove question mark

    # Add words to the set. This has the benefit of creating a unique set.
    set_of_words.add(normalized)

# Remove latin words from set
set_of_words.remove('shah')
set_of_words.remove('None')

# Sort from alap to taw
sorted_list_of_words = sorted(set_of_words)

# Print number of elements in list
print(len(sorted_list_of_words))

# Print them out line by line
print(*sorted_list_of_words, sep="\n")

cursor.close()
connect.close()
