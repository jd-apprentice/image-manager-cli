## 🙊 Token

- For this application to work we need a API_KEY from Pexels.

- The token is going to be provided in the application for the first time only and it will create a .txt file inside the folder containing the application and read it from there.

## 🏁 Pre-requisites

- An account from [Pexels](https://www.pexels.com/)
- Unix system
- Python 3

## 🏃 Run the script locally

```bash
# Giving permission to run the script
$ chmod +x ./run.sh

# If you dont want to send the token on the first iteration of the script
$ touch token.txt

# We populate the token here
$ vim token.txt

# Run the script
$ ./run.sh
```
