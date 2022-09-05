#!/bin/bash
# Author: Alon Ivtsan
# Edited for Void Linux by KS
# License: GPL3+

for FILE in *{.cbr,.CBR}
do
  [ -e "$FILE" ] || continue
  echo Converting $FILE to cbz format.
  DIR="${FILE%.*}"
  mkdir "$DIR";
  unrar e ./"$FILE" "$DIR";
  zip -r "$DIR".cbz "$DIR"/*;
  rm -r "$DIR";
  #Remove or comment out this line if you want to keep cbr files
  rm "$FILE";
  echo Conversion of $FILE successful!
done 
