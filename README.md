# Overview
A Syriac hunspell dictionary implementation

# Dictionary Files

sureth.dic: https://www.assyrianlanguages.org/sureth/, found under sql/sureth.csv

sedra.dic:  https://sedra.bethmardutho.org/about/sedra, licensed under Apache 2.0

# Installation

### Linux

Copy the relevant files in `/release`, namely `syr_SY.dic` and `syr_SY.aff` to `$HOME/.local/share/hunspell/`

```
mkdir -p $HOME/.local/share/hunspell/
sudo cp release/* $HOME/.local/share/hunspell/
```

Check that they have been loaded correctly

```
$ nuspell -D

Available dictionaries:
syr_SY          /home/emil/.local/share/hunspell/syr_SY
```

### Mac OS X

Install the nuspell library and tools per https://github.com/nuspell/nuspell

Copy the relevant files in release/, namely `syr_SY.dic` and `syr_SY.aff` to `/Library/Spelling/`
