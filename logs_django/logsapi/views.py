from datetime import datetime
import json
from random import randrange
import time
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics
from logins.models import AssignedSite, Sites, WorkLog, App
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from logsapi.serializer import AssignedSiteSerializer, SiteSerializer, WorkLogSerializer


@api_view()
def list(request):
    user = User.objects.get(username=request.user)
    print(user.__dict__)
    user_group = Group.objects.get(user=User.objects.get(id=user.id))
    app = App.objects.get(id=1)
    return Response({"name": f"{user.first_name} {user.last_name}", "group":user_group.name, "app":app.version})


@api_view(['GET'])
def logs_today(request):
    time.sleep(2)
    today = datetime.today().date()
    user = WorkLog.objects.filter(date=today, user=request.user)
    print(user)
    print(len(user))
    today = "0"
    login = "0"
    logout = "0"

    if len(user) == 1:
        if user[0].logout != None:
            today = "1"
            logout = user[0].logout
        if user[0].login != None:
            today = "1"
            login = user[0].login
    return Response({"today": today,"login": login,"logout": logout})


@api_view(['GET'])
def api_login(request):
    time.sleep(2)
    today = datetime.today().date()
    if len(WorkLog.objects.filter(date=today, user=request.user)) == 0:
        wl = WorkLog(user=request.user, place="Office")
        wl.login = datetime.now().strftime("%H:%M:%S")
        wl.date = datetime.now().strftime("%Y-%m-%d")
        wl.save()
        return Response({"status": "Successfully Logged In."})
    else:
        return Response({"status": "Already Logged In."})

@api_view(['GET'])
def api_logout(request):
    time.sleep(2)
    today = datetime.today().date()
    wl = WorkLog.objects.filter(date=today, user=request.user)
    if len(wl) == 1:
        if wl[0].logout == None:
            wlog = wl[0]
            wlog.logout = datetime.now().time().strftime("%H:%M:%S")
            wlog.save()
            return Response({"status": "Successfully Logged Out."})
        else:
            return Response({"status": "You are already logged out."})
    else:
        return Response({"status": "Login First."})

@api_view(['POST'])
def api_sites(request):
    time.sleep(2)
    body = request.body
    content = json.loads(body)
    today = datetime.now()
    site = Sites(user=request.user, number=content['mobile'], place=content['place'])
    site.otp = randrange(1556, 9573)
    site.date = today.strftime("%Y-%m-%d")
    site.time = today.time().strftime("%H:%M:%S")
    site.save()
    return Response({"status": "Successfully added site visit", "object":SiteSerializer(site).data})


@api_view(['POST'])
def api_sites_auth(request):
    time.sleep(2)
    body = request.body
    content = json.loads(body)
    print(content['id'])
    sites = Sites.objects.filter(id=content['id'])
    if (len(sites) == 1):
        site = sites[0]
        site.authenticated = True
        site.save()
        return Response({"status": "success", "object":SiteSerializer(site).data})
    else:
        return Response({"status": "failed", "object":SiteSerializer(site).data})


@api_view(['POST'])
def api_add_site_visit(request):
    time.sleep(2)
    body = request.body
    content = json.loads(body)
    site = Sites(
        user = request.user,
        date = datetime.now().strftime("%Y-%m-%d"),
        place = content["place"],
        time = datetime.now().strftime("%H:%M:%S"),
        number = content["mobile"],
        comment = "",
        )

    print(content["mobile"])
    assign = AssignedSite.objects.filter(number=content["mobile"], visited=False, visit_by=request.user)
    if len(assign) == 0:
        print("Manually entered number")
    else:
        print("Selected number")
        site.visit_assign_id = assign.first()
        assign_site = assign[0]
        assign_site.visited = True
        assign_site.save()

    site.save()
    return Response({"status": "success", "object":SiteSerializer(site).data})




@api_view(['GET'])
def pending_sites(request):
    time.sleep(2)
    print(request.user)
    sites = AssignedSite.objects.filter(visit_by=request.user, visited=False)
    print(sites)
    return Response({"sites": AssignedSiteSerializer(sites, many=True).data,})


@api_view(['GET'])
def mysites(request):
    time.sleep(2)
    print(request.user)
    sites = AssignedSite.objects.filter(visit_by=request.user, visited=False)
    print(sites)
    return Response({"sites": AssignedSiteSerializer(sites, many=True).data,})
