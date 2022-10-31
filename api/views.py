from django.shortcuts import render
from django.urls import reverse
from django.views.generic.edit import CreateView
from requests import Response
from .forms import AccountForm
from django.contrib import messages
from rest_framework import generics, permissions, authentication
from .models import Account
from .serializers import ApiAccountSerilizer
from rest_framework.authtoken.models import Token


# Create your views here.

import mysql.connector

def home(request):
    context = {}
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="all"
    )
    mycursor = mydb.cursor()
    
    mycursor.execute("SELECT * FROM noti")
    myresult = mycursor.fetchall()
    context["data"] = myresult

    return render(request, 'main.html', context)


class account(CreateView):
    template_name = 'home.html'
    form_class = AccountForm
    success_url = "/acc/"

    def get_success_url(self):
        messages.success(self.request, 'Form submitted successfully')
        return reverse('acc')

class api_account(generics.ListCreateAPIView):
    serializer_class = ApiAccountSerilizer
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    
class api_list(generics.ListCreateAPIView):
    serializer_class = ApiAccountSerilizer
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    queryset = Account.objects.all()

def api_verify(request, tkn):
    if Token.objects.filter(pk=tkn).exists():
        return Response({"token":"true"})
    else:
        return Response({'token':'false'})
