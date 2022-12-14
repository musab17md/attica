from datetime import datetime
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

# Create your models here.



class WorkLog(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateField(null=True, blank=True)
    place = models.CharField(max_length=300)
    login = models.TimeField(null=True, blank=True)
    logout = models.TimeField(null=True, blank=True)
    comment = models.CharField(max_length=300, null=True, blank=True)



class AssignedSite(models.Model): # Site assigned by admin to staff
    added_by = models.ForeignKey(User, on_delete=models.CASCADE)
    visit_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='visit_assigned_to')
    added_date = models.DateField(auto_now=True)
    name = models.CharField(max_length=50, null=True, blank=True)
    number = models.CharField(max_length=15, null=True, blank=True)
    address = models.CharField(max_length=300, null=True, blank=True)
    comment = models.CharField(max_length=300, null=True, blank=True)
    visited = models.BooleanField(default=False)



class Sites(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateField(null=True, blank=True)
    place = models.CharField(max_length=300, null=True, blank=True)
    time = models.TimeField(null=True, blank=True)
    number = models.CharField(max_length=15, null=True, blank=True)
    comment = models.CharField(max_length=300, null=True, blank=True)
    visit_assign_id = models.ForeignKey(AssignedSite, on_delete=models.SET_NULL, null=True, blank=True)# ID of AssignedSite model


class Profile(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    dob = models.CharField(max_length=300, null=True, blank=True)
    picture = models.ImageField(upload_to="profilepic/")
    number = models.CharField(max_length=300, null=True, blank=True)
    address = models.CharField(max_length=300, null=True, blank=True)




class App(models.Model):
    version = models.IntegerField(null=True, blank=True)
    app = models.FileField(upload_to="apk/")
    comment = models.CharField(max_length=300, null=True, blank=True)
    