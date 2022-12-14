from django.urls import path
from logins import views

urlpatterns = [
    path('homea/', views.home_admin, name='home_admin'),
    path('homeu/', views.home_user, name='home_user'),
    path('worklog/', views.worklog, name='worklog'),
    # path("register/", views.register_request, name="register"),
    path("login/", views.login_request, name="login"),
    path("logout/", views.logout_request, name="logout"),

    path("adduser/", views.add_user, name="adduser"),

    path("listuser/", views.list_user, name="listuser"),
    path("listremoveduser/", views.list_removed_user, name="listremoveduser"),

    path("remove/<int:id>/", views.remove_user, name="remove_user"),
    path("readd/<int:id>/", views.readd_user, name="readd_user"),

    path("active/<int:id>/", views.activate_user, name="activate_user"),
    path("inactive/<int:id>/", views.deactivate_user, name="deactivate_user"),
    
    path("profile/<int:id>/", views.user_profile, name="user_profile"),

    path("userlogs/", views.userlogs, name="userlogs"),
    path("addlogin/", views.addlogin, name="addlogin"),
    path("addlogout/", views.addlogout, name="addlogout"),
    # path("addsite/", views.addsite, name="addsite"),
    path("addsite1/<slug:number>/", views.addsite1, name="addsite1"), ## NUMBER PAGE
    path("addsite2/", views.addsite2, name="addsite2"), ## OTP PAGE
    path("assignsite/", views.assignsite, name="assignsite"),
    path("listassignedsites/", views.listassignedsites, name="listassignedsites"),
    path('listsitevisits/', views.listsitevisits, name='listsitevisits'),
    # path("siteotp/<slug:number>/", views.siteotp, name="siteotp"),

    path("sitedetail/", views.sitedetail, name="sitedetail"),
    path("attendance/", views.attendance, name="attendance"),
    path("monthattendance/", views.monthattendance, name="monthattendance"),

    path("test/", views.test, name="test"),
]
