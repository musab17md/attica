from logsapi import views
from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('auth/', obtain_auth_token),
    path('list/', views.list, name='list'),
    path('logs_today/', views.logs_today, name='logs_today'),
    path('api_login/', views.api_login, name='api_login'),
    path('api_logout/', views.api_logout, name='api_logout'),
    path('api_sites/', views.api_sites, name='api_sites'),
    path('api_sites_auth/', views.api_sites_auth, name='api_sites_auth'),
    path('pending_sites/', views.pending_sites, name='pending_sites'),
    path('api_add_site_visit/', views.api_add_site_visit, name='api_add_site_visit'),
    path('mysites/', views.mysites, name='mysites'),
    # path('apkfile/', views.apkfile, name='apkfile'),
    ]

