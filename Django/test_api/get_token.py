import json
import requests

auth_endpoint = "http://192.168.1.110:8123/auth/"
user = "Admin1"
passw = "admin1"

auth_response = requests.post(auth_endpoint, json={'username':user, 'password': passw})

print(auth_response.json())


