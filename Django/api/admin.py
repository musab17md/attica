from django.contrib import admin

from .models import *

# Register your models here.

class NotiAdmin(admin.ModelAdmin):
    list_display = ('id', 'product_name', 'ornament', 'submitdate', 'status', 'image')

class Pics2Admin(admin.ModelAdmin):
    list_display = ('id', 'vendor', 'ornament', 'date', 'status')

admin.site.register(Noti, NotiAdmin)
admin.site.register(Pics2, Pics2Admin)