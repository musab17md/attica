from django.urls import path
from . import views
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('auth/', obtain_auth_token),
    path('users/', views.get_users.as_view(), name="users"),
    path('currentuser/', views.currentuser, name="currentuser"),

    
    path('', views.home, name="home"),
    path('noti/', views.api_noti.as_view(), name="noti"),
    path('noti/<int:pk>/', views.noti_ReUpDeApi.as_view(), name="noti_edit"),
    path('pics/', views.api_pics.as_view(), name="pics"),
    path('pics/<int:pk>/', views.pics_ReUpDeApi.as_view(), name="pics_edit"),
    path('pics/<slug:ornament>/', views.get_photographer_ornament.as_view(), name="get_photographer_ornament"),
    
    # path('pics2/', views.api_pics2.as_view(), name="pics2"),
    # path('pics2/<int:pk>/', views.api_pics2.as_view(), name="pics2"),
    # path('pics2/<slug:status>/', views.api_pics_status.as_view(), name="pics_status"),
    # path('pics2/<slug:status>', views.api_pics2, name="pics2"),
    # path('web/uploadimage/', views.uploadImage, name="uploadImage"),
    # path('acc/', views.account.as_view(), name="acc"),

    # path('api_verify/<str:tkn>', views.api_verify, name="api_verify"),

    # path('api_acc/', views.api_account.as_view(), name="api_acc"),

    # path('api/datalist/', views.api_list.as_view(), name="api_acc"),
]
