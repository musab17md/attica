from rest_framework import serializers
# from .models import Account
from .models import *
from django.contrib.auth.models import User


# class ApiAccountSerilizer(serializers.ModelSerializer):
#     class Meta:
#         model = Account
#         fields = "__all__"

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = "__all__"

class ApiNotiSerilizer(serializers.ModelSerializer):
    class Meta:
        model = Noti
        fields = "__all__"


class ApiPicsSerilizer(serializers.ModelSerializer):
    class Meta:
        model = Pics2
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