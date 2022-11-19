import json
import requests

token = "c73ec9b6cc036bb849b23b01f7c90ad6ea6a491a"
address = "http://192.168.0.134:8123/"


def getuser():
    json = {'username':'msb', 'password':'mmmmm'}
    endpoint = f"{address}authenticate/"
    post_response = requests.post(endpoint, json=json)
    print(post_response)
    print(post_response.json())

getuser()



def getuser2():
    headers = {"Authorization": f"Token {token}"}
    endpoint = f"{address}currentuser/"
    post_response = requests.get(endpoint, json={'username':'msb', 'password':'mmmmm'})
    print(post_response)
    print(post_response.json())

# getuser2()