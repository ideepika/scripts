#!/bin/bash

if [ -n "$1" ]
then
  PGP_KEY_ID=CED8B95F
  ENCRYPTED_FILE=${1}
  TEMP_FILE=/tmp/gpg-edit-temp # TODO: test if file exists and loop through .0, .1, etc. to avoid collisions

  if [ -f "$ENCRYPTED_FILE" ] # if file exists, decrypt
  then
    echo "Decrypting..."
    gpg -o "$TEMP_FILE" -d "$ENCRYPTED_FILE"
  else
    echo "File does not exist, will be created by your editor."
  fi

  $EDITOR "$TEMP_FILE"
  echo "Encrypting..."
  gpg -o "$ENCRYPTED_FILE" -ear $PGP_KEY_ID "$TEMP_FILE"
  rm "$TEMP_FILE"
  echo "Done."
else
  echo "Error: No file name given."
fi
