#!/bin/bash

## Initial variables
base_url=https://api.pexels.com/v1
url=https://www.pexels.com/
key=https://www.pexels.com/api/new/
pexels_file=token.txt
pexels_query=wallpaper
pexels_amount=1
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
  - Default is $pexels_amount
  - Only enter numbers
  - 1-10 images per request
-> " images
  done
}

isGreaterThan10() {
  if [[ $images -gt 10 || $images == 0 ]]; then
    echo "ERROR: That amount is not allowed"
    exit 1
  fi
  writeSpace
}

readQueryInput() {
  read -p "
- Default is $pexels_query
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
    "$base_url/search?query=$default_query&per_page=$default_amount" | python3 -m json.tool >>response.json
}

readTokenInput() {
  read -p "
Enter your pexels api token
You can create your account here $url
After that you can visit $key
-> " token && echo $token > token.txt
  writeSpace
}

runApplication() {
  if [[ -e "token.txt" ]]; then

    ## Retrieve amount of images
    isNumberInput
    isGreaterThan10
    default_amount=${images:-$pexels_amount}

    ## Query
    readQueryInput
    default_query=${query:-$pexels_query}

    ## Info messages and download images
    infoMessages
    downloadImages
    writeSpace

    ## We run the python script
    chmod +x main.py
    ./main.py

    ## Clean the response object
    rm response.json

  elif ! [[ -e "token.txt" ]]; then

    readTokenInput
    runApplication

  fi
}

## Token
api_key=${pexels_token:-$token}

## Run the application
runApplication

## Exit
exit 1