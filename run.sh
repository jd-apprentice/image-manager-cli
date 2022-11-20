#!/bin/bash

## Initial variables
url=https://www.pexels.com/
key=https://www.pexels.com/api/new/
pexels_file=token.txt
pexels_query=nature
pexels_token=

## Read token
read -r -a words <$pexels_file || ((${#words[@]}))
for word in "${words[@]}"; do
  pexels_token="$word"
done

## Functions
writeSpace() {
  echo " "
}

isNumberInput() {
  unset images
  until [[ $images == +([0-9]) ]]; do
    read -p "
  How many images do you want?
  - Default is 1 
  - Only enter numbers
  - 1-10 images per request
-> " images
  done
  writeSpace
}

isGreaterThan10() {
  if [[ $images -gt 10 || $images == 0 ]]; then
    echo "ERROR: That amount is not allowed"
    exit 1
  fi
  writeSpace
}

readTokenInput() {
  read -sp "
Enter your pexels api token
You can create your account here $url
After that you can visit $key
-> " token
  writeSpace
}

readQueryInput() {
  read -p "
  - Default is nature
  - Options are Cars, Tigers, People, Food, Etc
  - Or it could be something specific like Group of people working
  -> " query
}

infoMessages() {
  echo "You asked for $default_amount images"
  echo "Proceeding to fetch the images"
  writeSpace
}

downloadImages() {
  curl -H "Authorization: $api_key" \
    "https://api.pexels.com/v1/search?query=$default_query&per_page=$default_amount&" | python3 -m json.tool >>response.json
}

## Retrieve amount of images
isNumberInput
isGreaterThan10
default_amount=${images:-1}

## Token
readTokenInput
api_key=${token:-$pexels_token}

## Query
readQueryInput
default_query=${query:-$pexels_query}

## Info messages and download images
infoMessages
downloadImages
writeSpace

## Exit
echo "Exiting..."
exit 1
