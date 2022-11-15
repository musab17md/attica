import json
import requests

token = "c73ec9b6cc036bb849b23b01f7c90ad6ea6a491a"
address = "http://192.168.0.134:8123/"


def post_data():

    headers = {"Authorization": f"Token {token}"}
    endpoint = f"{address}pics/"
    post_response = requests.post(endpoint, headers=headers, data={'select_metal':'Gold', 'ornament_type':'anklets', 'purity': 6000})
    print(post_response)
    print(post_response.json())

# post_data()



def get_data():

    headers = {"Authorization": f"Token {token}"}
    endpoint = f"{address}pics/"
    post_response = requests.get(endpoint, headers=headers)
    print(post_response)
    print(post_response.json())

get_data()