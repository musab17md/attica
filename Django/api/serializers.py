from rest_framework import serializers
# from .models import Account
from api.models import *
import re


# class ApiAccountSerilizer(serializers.ModelSerializer):
#     class Meta:
#         model = Account
#         fields = "__all__"


def get_choices():
    groups = Group.objects.all()
    choices = []
    for gr in groups:
        print(gr.group_name)
        choices.append([gr.group_name,gr.group_name])
    print(choices)
    return choices

# choices=(("Admin","Admin"),("Vendor","Vendor"))

class UserSerializer(serializers.ModelSerializer):
    type = serializers.ChoiceField(choices=get_choices())
    class Meta:
        model = User
        fields = ['id','type','username','password','branch','agent','date','active']
    # def validate_username(self, value):
    #     if bool(re.search(pattern="\s",string=value)):
    #         raise serializers.ValidationError("Username should not contain spaces")
    #     if bool(re.search(pattern="[^a-zA-Z0-9]",string=value)):
    #         raise serializers.ValidationError("Allowed characters are alphabet and numbers")
    #     if User.objects.filter(username=value).exists():
    #         raise serializers.ValidationError("A user with this username already exists!")
    #     return value
    
    def validate_password(self, value):
        if bool(re.search(pattern="[\s\r\n]",string=value)):
            raise serializers.ValidationError("Password should not contain spaces")
        if len(value) < 5:
            raise serializers.ValidationError("Password length should be more then 5 characters")
        # TO DO: Implement week password detect
        # TO DO: Password change otp
        return value


class UserTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['type','username','password','branch','agent','date','active']



class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = "__all__"


class ApiNotiSerilizer(serializers.ModelSerializer):
    class Meta:
        model = Noti
        fields = "__all__"


class ApiPicsSerilizer(serializers.ModelSerializer):
    class Meta:
        model = Pics2
        fields = "__all__"


class GoldSerilizer(serializers.ModelSerializer):
    class Meta:
        model = Gold
        fields = "__all__"


class ApiPicsSerilizer2(serializers.Serializer):
    vendor = serializers.CharField(max_length=150)
    ornament = serializers.CharField(max_length=150)
    model1 = serializers.ImageField()
    model2 = serializers.ImageField()
    video = serializers.FileField()
    pic1 = serializers.ImageField()
    pic2 = serializers.ImageField()
    pic3 = serializers.ImageField()
    time = serializers.CharField(max_length=50)
    date = serializers.CharField(max_length=50)
    status = serializers.CharField(max_length=100)

    def create(self, validated_data):
        """
        Create and return a new `Snippet` instance, given the validated data.
        """
        return Pics2.objects.create(**validated_data)

    # def update(self, instance, validated_data):
    #     """
    #     Update and return an existing `Snippet` instance, given the validated data.
    #     """
    #     instance.title = validated_data.get('title', instance.title)
    #     instance.code = validated_data.get('code', instance.code)
    #     instance.linenos = validated_data.get('linenos', instance.linenos)
    #     instance.language = validated_data.get('language', instance.language)
    #     instance.style = validated_data.get('style', instance.style)
    #     instance.save()
    #     return instance