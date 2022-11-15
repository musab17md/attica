import json
import requests




def auth_response_get_token():
    auth_endpoint = "http://localhost:8080/auth/"
    auth_response = requests.post(auth_endpoint, json={'username':'msb', 'password':'msb'})
    print(auth_response)
    print(auth_response.json())
    return auth_response


# auth_response_get_token()


def post_data():
    token = "68c2a7cc5e09dd2a179438f50d1fd0350096b08b"

    headers = {"Authorization": f"Token {token}"}
    endpoint = "http://192.168.0.134:8123/pics/"
    post_response = requests.post(endpoint, headers=headers, data={'select_metal':'Gold', 'ornament_type':'anklets', 'purity': 6000})
    print(post_response)
    print(post_response.json())

# post_data()


import mysql.connector


def get_data():
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="all"
    )
    print(mydb)

    mycursor = mydb.cursor()
    
    mycursor.execute("SELECT * FROM noti")
    myresult = mycursor.fetchall()
    for x in myresult:
        print(x)

# get_data()

