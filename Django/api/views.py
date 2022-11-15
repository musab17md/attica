from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views.generic.edit import CreateView
# from requests import Response
from .forms import *
from django.contrib import messages
from rest_framework import generics, permissions, authentication
from .models import *
from .serializers import *
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view
from rest_framework import status, mixins, permissions
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework.views import APIView
import json


# Create your views here.

import mysql.connector


def home(request):
    return render(request, 'main.html')


class api_noti(generics.ListCreateAPIView):
    serializer_class = ApiNotiSerilizer
    queryset = Noti.objects.all()
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]


class noti_ReUpDeApi(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ApiNotiSerilizer
    queryset = Noti.objects.all()
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

class api_pics(generics.ListCreateAPIView):
    serializer_class = ApiPicsSerilizer
    queryset = Pics2.objects.all()
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]


class pics_ReUpDeApi(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ApiPicsSerilizer
    queryset = Pics2.objects.all()
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

class get_photographer_ornament(generics.ListAPIView):
    serializer_class = ApiPicsSerilizer
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        ornament = self.kwargs['ornament']
        ornament = ornament.replace("_", " ")
        return Pics2.objects.filter(ornament = ornament)


class get_users(generics.ListAPIView):
    serializer_class = UserSerializer
    queryset = User.objects.all()
    authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]


from django.contrib.auth.models import Group
@api_view(['POST'])
def currentuser(request):
    print(request.body)
    data = json.loads(request.body)
    # user = Token.objects.get(key=data["usr"]).user
    # user = Token.objects.filter(key=data["usr"])[0].user
    users = Token.objects.filter(key=data["usr"])
    if len(users) == 1:
        user = users[0].user
        user_groups = Group.objects.filter(user = user.id)
        ugroups = ""
        for ug in user_groups:
            ugroups = ug.name + "|"
        return Response({
            'id':user.id,
            'username':user.username,
            'is_superuser': user.is_superuser,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'email': user.email,
            'is_staff': user.is_staff,
            'is_active': user.is_active,
            'groups': ugroups[:-1],
            })
    else:
        return Response({'usr':'invalid'})




# class api_pics_status(generics.ListAPIView):
#     serializer_class = ApiPicsSerilizer
    
#     def get_queryset(self):
#         status = self.kwargs['status']
#         return Pics2.objects.filter(status = status)



# class api_pics2(mixins.ListModelMixin, mixins.RetrieveModelMixin, generics.GenericAPIView):
#     serializer_class = ApiPicsSerilizer
#     queryset = Pics2.objects.all()
#     lookup_field = ['pk', 'status']

#     def get(self, request, *args, **kwargs):
#         print(args, kwargs)
#         pk = kwargs.get("pk")
#         if pk is not None:
#             return self.retrieve(request, *args, **kwargs)
            
#         status = kwargs.get("status")
#         if status is not None:
#             return self.list(request, *args, **kwargs)
            
#         return self.list(request, *args, **kwargs)



# @api_view(['GET', 'POST'])
# def api_pics2(request):
#     if request.method == 'GET':
#         snippets = Pics2.objects.all()
#         serializer = ApiPicsSerilizer2(snippets, many=True)
#         return Response(serializer.data)

#     elif request.method == 'POST':
#         serializer = ApiPicsSerilizer2(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data)
#         return Response(serializer.errors)


# def uploadImage(request):
  
#     if request.method == 'POST':
#         form = PicsForm(request.POST, request.FILES)
        
#         print("received post")
  
#         if form.is_valid():
#             print("form is valid")
#             form.save()
#             return redirect('uploadImage')
#         else:
#             print(form.errors)
#             print("form not valid")
#     else:
#         form = PicsForm()
#     return render(request, 'uploadimg.html', {'form' : form})


# class uploadImage(CreateView):
#     template_name = 'uploadimg.html'
#     form_class = PicsForm
#     success_url = "/web/uploadimage/"
    # def get_success_url(self):
    #     messages.success(self.request, 'Form submitted successfully')
    #     return reverse('uploadImage')

# def home(request):
#     context = {}
#     mydb = mysql.connector.connect(
#         host="localhost",
#         user="root",
#         password="",
#         database="all"
#     )
#     mycursor = mydb.cursor()
    
#     mycursor.execute("SELECT * FROM noti")
#     myresult = mycursor.fetchall()
#     context["data"] = myresult

#     return render(request, 'main.html', context)


# class account(CreateView):
#     template_name = 'home.html'
#     form_class = AccountForm
#     success_url = "/acc/"

#     def get_success_url(self):
#         messages.success(self.request, 'Form submitted successfully')
#         return reverse('acc')

# class api_account(generics.ListCreateAPIView):
#     serializer_class = ApiAccountSerilizer
#     authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
#     permission_classes = [permissions.IsAuthenticated]
    
# class api_list(generics.ListCreateAPIView):
#     serializer_class = ApiAccountSerilizer
#     authentication_classes = [authentication.SessionAuthentication, authentication.TokenAuthentication]
#     permission_classes = [permissions.IsAuthenticated]
#     queryset = Account.objects.all()

# def api_verify(request, tkn):
#     if Token.objects.filter(pk=tkn).exists():
#         return Response({"token":"true"})
#     else:
#         return Response({'token':'false'})
