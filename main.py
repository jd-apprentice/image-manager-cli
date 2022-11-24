#!/usr/bin/env python3
import json

# We read from the json
def read_json(path):
    with open(path, mode="rt") as file:
        return json.load(file)

# Function to print the photos
def print_photos_url(json_data):
    for photo in json_data['photos']:
        try:
            print(photo['src']['original'])
        except:
            print("Could not find images, please try again")

# We execute the script
if __name__ == "__main__":
    json_data = read_json(path="response.json")
    print_photos_url(json_data=json_data)