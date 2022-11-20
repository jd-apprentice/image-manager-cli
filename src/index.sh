#!/bin/bash

## Initial variables
url=https://www.pexels.com/
key=https://www.pexels.com/api/new/

## Set user token
read -sp "
Enter your pexels api token
You can create your account here $url
After that you can visit $key
-> " token

## Space
echo " "

## Set amount of imges
read -p "
How many images do you want?
- Default is 1 
- Only enter numbers
-> " images

## Validate if the input is a number
if [[ $images =~ '/^[A-Za-z]+$/i' ]]; then
  echo "ERROR: Amount is not a number exiting.."
  exit 1
elif [[ $images -gt 10 ]]; then
  echo "ERROR: Exceded the maximum amount of images"
  echo "Amount of images set to 1"
  unset images
fi

## Input variables
api_key=$token
amount_images=$images
default_amount=${amount_images:-1}

## Info messages
echo "Your api token is set"
echo "You asked for $default_amount images"
echo "Proceeding to fetch the images"

## Download image
download_images() {
  curl -H "Authorization: $api_key" \
    "https://api.pexels.com/v1/search?query=nature&per_page=$default_amount" | python3 -m json.tool >>response.json
}

download_images
