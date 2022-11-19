from django.contrib import admin

from api.models import *

# Register your models here.

class NotiAdmin(admin.ModelAdmin):
    list_display = ('id', 'product_name', 'ornament', 'submitdate', 'status', 'image')

class Pics2Admin(admin.ModelAdmin):
    list_display = ('id', 'vendor', 'vendor_id', 'ornament', 'date', 'status')
    list_editable = ('vendor', 'vendor_id', 'ornament', 'date', 'status')


class UserAdmin(admin.ModelAdmin):
    list_display = ('id', 'type', 'username', 'password', 'branch', 'agent', 'active', 'date')
    list_editable = ('type', 'username', 'password', 'branch', 'agent', 'active', 'date')

class GoldAdmin(admin.ModelAdmin):
    list_display = ('id', 'metal', 'rate', 'vendor', 'vendor_id', 'date')
    list_editable = ('metal', 'rate', 'vendor', 'vendor_id', 'date')

admin.site.register(Noti, NotiAdmin)
admin.site.register(Pics2, Pics2Admin)
admin.site.register(User, UserAdmin)
admin.site.register(Gold, GoldAdmin)

