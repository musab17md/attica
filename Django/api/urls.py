from django.urls import path
from api import views
# from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    # path('auth/', obtain_auth_token),
    
    path('authenticate/', views.Auth_ReApi, name="authenticate"),
    path('users/', views.user_LiCrApi.as_view(), name="users"),
    path('groups/', views.group_LiCrApi.as_view(), name="group"),
    path('currentuser/', views.currentuser, name="currentuser"),
    path('changepass/', views.changepass, name="changepass"),
    path('vendors/', views.vendors.as_view(), name="vendors"),
    
    path('', views.home, name="home"),
    path('gold/', views.metal_get, name="gold"),
    # path('gold/<int:vendor_id>/', views.metal_retrive.as_view(), name="gold"),
    path('noti/', views.api_noti.as_view(), name="noti"),
    path('noti/vendor/<slug:vendor_id>/', views.noti_vendor.as_view(), name="noti_vendor"),
    path('noti/<int:pk>/', views.noti_ReUpDeApi.as_view(), name="noti_edit"),
    path('pics/', views.api_pics.as_view(), name="pics"),
    path('pics/vendor/<slug:vendor_id>/', views.pics_vendor.as_view(), name="pics_vendor"),
    path('pics/<int:pk>/', views.pics_ReUpDeApi.as_view(), name="pics_edit"),
    path('pics/<slug:ornament>/<slug:vendor_id>/', views.get_photographer_ornament.as_view(), name="get_photographer_ornament"),
    
    
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
