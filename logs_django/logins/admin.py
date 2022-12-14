from django.contrib import admin
from logins.models import WorkLog, Sites, AssignedSite, Profile, App
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User


# Register your models here.
class UserAdminWithGroup(UserAdmin):
    def group_name(self, obj):
        queryset = obj.groups.values_list('name',flat=True)
        groups = []
        for group in queryset:
            groups.append(group)
        
        return ' '.join(groups)

    list_display = UserAdmin.list_display + ('group_name',)


class WorkLogAdmin(admin.ModelAdmin):
    list_display = ('user', 'date', 'place', 'login', 'logout',)

class AssignedSiteAdmin(admin.ModelAdmin):
    list_display = ('id', 'visit_by', 'added_date', 'name', 'number', 'address',)

class SitesAdmin(admin.ModelAdmin):
    list_display = ('user', 'date', 'place', 'number',)


admin.site.register(WorkLog, WorkLogAdmin)
admin.site.register(AssignedSite, AssignedSiteAdmin)
admin.site.register(Sites, SitesAdmin)
admin.site.register(Profile)
admin.site.register(App)




admin.site.unregister(User)
admin.site.register(User, UserAdminWithGroup)