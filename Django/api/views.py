from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render
# from requests import Response
from api.forms import *
from rest_framework import generics
from api.models import *
from api.serializers import *
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view
from rest_framework.response import Response
# from django.contrib.auth.models import User
import json


# Create your views here.



def home(request):
    return render(request, 'main.html')


class metal_retrive(generics.RetrieveUpdateAPIView):
    serializer_class = GoldSerilizer
    queryset = Gold.objects.all()
    lookup_field = "vendor_id"


# class metal_create(generics.CreateAPIView):
#     serializer_class = GoldSerilizer
#     queryset = Gold.objects.all()
@api_view(['GET', 'POST'])
def metal_get(request):
    # if request.method == 'POST':
    print(request.data)
    print(type(request.data))
    print(request.data["vendor_id"])
    if "vendor" in request.data:
        try:
            print("vend exists")
            gold = Gold.objects.get(vendor_id=request.data["vendor_id"])
            gold.metal = request.data["metal"]
            gold.rate = request.data["rate"]
            gold.vendor = request.data["vendor"]
            gold.time = request.data["time"]
            gold.date = request.data["date"]
            gold.save()
            return Response({"Rate":"added"})
        except:
            return Response({"Rate":"An error occured"})
    else:
        print("not exists")
        gold, created = Gold.objects.get_or_create(vendor_id=request.data["vendor_id"])
        serializer = GoldSerilizer(gold)
        return Response(serializer.data)

    # if request.method == 'GET':
    #     snippets = Snippet.objects.all()
    #     serializer = SnippetSerializer(snippets, many=True)
    #     return Response(serializer.data)

    # elif request.method == 'POST':
    #     serializer = SnippetSerializer(data=request.data)
    #     if serializer.is_valid():
    #         serializer.save()
    #         return Response(serializer.data, status=status.HTTP_201_CREATED)
    #     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class api_noti(generics.ListCreateAPIView):
    serializer_class = ApiNotiSerilizer
    queryset = Noti.objects.all()


class noti_vendor(generics.ListAPIView):
    serializer_class = ApiNotiSerilizer
    
    def get_queryset(self):
        vendor_id = self.kwargs['vendor_id']
        return Noti.objects.filter(vendor_id = vendor_id)


class noti_ReUpDeApi(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ApiNotiSerilizer
    queryset = Noti.objects.all()


class api_pics(generics.ListCreateAPIView):
    serializer_class = ApiPicsSerilizer
    queryset = Pics2.objects.all()


class pics_ReUpDeApi(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ApiPicsSerilizer
    queryset = Pics2.objects.all()


class pics_vendor(generics.ListAPIView):
    serializer_class = ApiPicsSerilizer
    
    def get_queryset(self):
        vendor_id = self.kwargs['vendor_id']
        return Pics2.objects.filter(vendor_id = vendor_id)


class get_photographer_ornament(generics.ListAPIView):
    serializer_class = ApiPicsSerilizer
    
    def get_queryset(self):
        ornament = self.kwargs['ornament']
        ornament = ornament.replace("_", " ")
        return Pics2.objects.filter(ornament = ornament)


# class get_users(generics.ListAPIView):
#     serializer_class = UserSerializer
#     queryset = User.objects.all()


class user_LiCrApi(generics.ListCreateAPIView):
    serializer_class = UserSerializer
    queryset = User.objects.all()


@api_view(["post"])
def Auth_ReApi(request):
    # data["username"] = ""
    # data["password"] = ""
    data = json.loads(request.body)
    mydata = get_object_or_404(User, username=data["username"], password=data["password"])
    serializer = UserSerializer(mydata)
    return JsonResponse(serializer.data)


@api_view(["post"])
def changepass(request):
    data = json.loads(request.body)
    print(data)
    mydata = get_object_or_404(User, username=data["username"])
    mydata.password = data["password"]
    mydata.save()
    serializer = UserSerializer(mydata)
    return JsonResponse(serializer.data)


class vendors(generics.ListAPIView):
    serializer_class = UserSerializer
    def get_queryset(self):
        return User.objects.filter(type = "Vendor")


class group_LiCrApi(generics.ListCreateAPIView):
    serializer_class = GroupSerializer
    queryset = Group.objects.all()


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
