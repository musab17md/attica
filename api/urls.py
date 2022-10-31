from django.urls import path
from . import views
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('auth/', obtain_auth_token),

    
    path('', views.home, name="home"),
    path('acc/', views.account.as_view(), name="acc"),

    path('api_verify/<str:tkn>', views.api_verify, name="api_verify"),

    path('api_acc/', views.api_account.as_view(), name="api_acc"),

    path('api/datalist/', views.api_list.as_view(), name="api_acc"),
]
