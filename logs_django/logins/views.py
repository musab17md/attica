from datetime import datetime, date, time
from random import randrange
from django.http import HttpResponse
from django.shortcuts import render, redirect
from logins.forms import AssignedSiteForm, NewUserForm
from django.contrib.auth import login, logout
from django.contrib import messages
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from logins.models import AssignedSite, Sites, WorkLog





def register_request(request):
	if request.method == "POST":
		form = NewUserForm(request.POST)
		if form.is_valid():
			user = form.save()
			login(request, user)
			messages.success(request, "Registration successful." )
			return redirect("home")
		messages.error(request, "Unsuccessful registration. Invalid information.")
	form = NewUserForm()
	return render (request=request, template_name="register.html", context={"register_form":form})


def login_request(request):
	if request.method == "POST":
		form = AuthenticationForm(request, data=request.POST)
		if form.is_valid():
			username = form.cleaned_data.get('username')
			password = form.cleaned_data.get('password')
			user = authenticate(username=username, password=password)
			if user is not None:
				login(request, user)
				messages.info(request, f"You are now logged in as {username}.")
				if request.user.is_superuser:
					return redirect("home_admin")
				else:
					return redirect("home_user")
			else:
				messages.error(request,"Invalid username or password.")
		else:
			messages.error(request,"Invalid username or password.")
	form = AuthenticationForm()
	return render(request=request, template_name="login.html", context={"login_form":form})



@login_required(login_url='/login/')
def logout_request(request):
	logout(request)
	return redirect("login")


@login_required(login_url='/login/')
def home_admin(request):
	if request.user.is_superuser:
		context = {}
		return render(request, 'home_admin.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")



@login_required(login_url='/login/')
def home_user(request):
	if not request.user.is_superuser and request.user.is_staff:
		context = {}
		return render(request, 'home_user.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")



@login_required(login_url='/login/')
def worklog(request):
	if not request.user.is_superuser and request.user.is_staff:
		context = {}
		context["logs"] = WorkLog.objects.filter(user=request.user).order_by('-date')
		return render(request, 'worklog.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def add_user(request):
	if request.user.is_superuser:
		if request.method == "POST":
			form = NewUserForm(request.POST)
			if form.is_valid():
				user = form.save()
				# login(request, user)
				messages.success(request, "User added successfully" )
				return redirect("adduser")
			form = NewUserForm(request.POST)
			messages.error(request, "Unsuccessful registration. Invalid information.")
			return render(request, 'adduser.html', context={"register_form":form})
		form = NewUserForm()
		return render(request, 'adduser.html', context={"register_form":form})
	return HttpResponse("<html><body>Unauthorized</body></html>")



@login_required(login_url='/login/')
def list_user(request):
	if request.user.is_superuser:
		context = {}
		acitveuser = User.objects.filter(is_staff=True, is_superuser=False)
		inacitveuser = User.objects.filter(is_staff=False, is_active=True, is_superuser=False)
		context['acitveuser'] = acitveuser
		context['inacitveuser'] = inacitveuser
		return render(request, 'listuser.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def list_removed_user(request):
	if request.user.is_superuser:
		context = {}
		users = User.objects.filter(is_active=False, is_superuser=False)
		context['users'] = users
		return render(request, 'removeduser.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def remove_user(request, id):
	if request.user.is_superuser:
		user = User.objects.get(id=id)
		user.is_active = False
		user.save()
		return redirect("listuser")
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def readd_user(request, id):
	if request.user.is_superuser:
		user = User.objects.get(id=id)
		user.is_active = True
		user.save()
		return redirect("listremoveduser")
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def activate_user(request, id):
	if request.user.is_superuser:
		user = User.objects.get(id=id)
		user.is_staff = True
		user.save()
		return redirect("listuser")
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def deactivate_user(request, id):
	if request.user.is_superuser:
		user = User.objects.get(id=id)
		user.is_staff = False
		user.save()
		return redirect("listuser")
	return HttpResponse("<html><body>Unauthorized</body></html>")



@login_required(login_url='/login/')
def user_profile(request, id):
	if not request.user.is_superuser and request.user.is_staff:
		context = {}
		user = User.objects.get(id=id)
		context['user'] = user
		return render(request, 'profile.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")


######### LOGIN LOGOUT ##########
@login_required(login_url='/login/')
def userlogs(request):
	if not request.user.is_superuser and request.user.is_staff:
		today = datetime.today().date()
		context = {}
		user = WorkLog.objects.filter(date=today, user=request.user)
		print(user)
		context['user'] = user
		return render(request, 'userlogs.html', context)
	return HttpResponse("<html><body>Unauthorized</body></html>")

@login_required(login_url='/login/')
def addlogin(request):
	if not request.user.is_superuser and request.user.is_staff:
		today = datetime.today().date()
		if len(WorkLog.objects.filter(date=today, user=request.user)) == 0:
			wl = WorkLog(user=request.user, place="Office")
			# wl.login = datetime.now().time().strftime("%I:%M:%S")
			wl.login = datetime.now().strftime("%H:%M:%S")
			wl.date = datetime.now().strftime("%Y-%m-%d")
			wl.save()
			messages.success(request,"Successfully Logged In.")
			return redirect("userlogs")
		else:
			messages.error(request,"Already Logged In.")
			return redirect("userlogs")
	return HttpResponse("<html><body>Unauthorized</body></html>")
	
@login_required(login_url='/login/')
def addlogout(request):
	if not request.user.is_superuser and request.user.is_staff:
		today = datetime.today().date()
		wl = WorkLog.objects.filter(date=today, user=request.user)
		if len(wl) == 1:
			if wl[0].logout == None:
				wlog = wl[0]
				wlog.logout = datetime.now().time().strftime("%H:%M:%S")
				wlog.save()
				messages.success(request,"Successfully Logged Out.")
				return redirect("userlogs")
			else:
				messages.error(request,"You are already logged out.")
				return redirect("userlogs")
		else:
			messages.error(request,"Login First.")
			return redirect("userlogs")
	return HttpResponse("<html><body>Unauthorized</body></html>")

# @login_required(login_url='/login/')
# def addsite(request):
# 	if not request.user.is_superuser and request.user.is_staff:
# 		if request.method == "POST":
# 			form = Site1Form(request.POST)
# 			if form.is_valid():
# 				user = form.save()
# 				messages.success(request, "User added successfully" )
# 				return redirect("addsite")
# 			form = Site1Form(request.POST)
# 			messages.error(request, "Unsuccessful registration. Invalid information.")
# 			return render(request, 'addsite.html', context={"site_visit_form":form})
# 		form = Site1Form()
# 		return render(request, 'addsite.html', context={"site_visit_form":form})
# 	return HttpResponse("<html><body>Unauthorized</body></html>")
# @login_required(login_url='/login/')
# def addsite(request):
# 	if not request.user.is_superuser and request.user.is_staff:
# 		if request.method == "POST":
# 			print(request.POST.get("number"))
# 			print(request.__dict__)
# 			today = datetime.today().date()
# 			site = Sites(
# 				user = request.user,
# 				date = datetime.now().strftime("%Y-%m-%d"),
# 				place = "",
# 				time = datetime.now().strftime("%I:%M:%S"),
# 				number = "",
# 				otp = "",
# 				authenticated = "",
# 				comment = "",
# 				)
# 			if request.POST.get("assigned") != "":
# 				vsite = AssignedSite.objects.get(id=int(request.POST.get("assigned")))
# 				site.visit_assign_id = vsite
# 			site.save()
# 			messages.success(request, "Site added successfully" )
# 			return redirect("addsite")

# 		visits = AssignedSite.objects.filter(visit_by=request.user)
# 		return render(request, 'addsite.html', context={"visits":visits})
# 	return HttpResponse("<html><body>Unauthorized</body></html>")
@login_required(login_url='/login/')
def addsite1(request, number): ## ENTER NUMBER PAGE ##
	if not request.user.is_superuser and request.user.is_staff:
		request.session['current_otp'] = ""
		if request.method == "POST":
			if len(number) != 10:
				messages.error(request, "Required 10 digits number")
				return redirect("addsite1")
			# if not request.POST.get("number").isnumeric():
			# 	messages.error(request, "Required numnber format")
			# 	return redirect("addsite1")
			# print(request.POST.get("number"))
			# print(request.__dict__)
			messages.success(request, "Number Saved")
			request.session['chosen_number'] = number
			request.session['current_otp'] = randrange(105484, 994265)
			
			print(request.session['chosen_number'])
			print(request.user)
			
			return redirect("addsite2")
		visits = AssignedSite.objects.filter(number=number, visited=False)
		if len(visits) != 0:
			print(visits)
			return render(request, 'addsite.html', context={"visits":visits[0]})
		else:
			messages.error(request, "An error occured")
			return redirect("listassignedsites")
	return HttpResponse("<html><body>Unauthorized</body></html>")

@login_required(login_url='/login/')
def addsite2(request): ## ENTER OTP PAGE ##
	if not request.user.is_superuser and request.user.is_staff and request.session['current_otp'] != "":
		if request.method == "POST":
			
			print(request.session['current_otp'])
			print(request.POST.get("otp"))

			if len(request.POST.get("otp")) != 6:
				messages.error(request, "Required 6 digits number")
				return redirect("addsite2")
			if request.session['current_otp'] == int(request.POST.get("otp")):
				messages.success(request, "Authentication successfull")
				request.session['current_otp'] = ""
				today = datetime.today().date()

				site = Sites(
					user = request.user,
					date = datetime.now().strftime("%Y-%m-%d"),
					place = "coordinate not available from browser",
					time = datetime.now().strftime("%I:%M:%S"),
					number = request.session['chosen_number'],
					comment = "",
					)

				assign = AssignedSite.objects.filter(number=request.session['chosen_number'], visited=False, visit_by=request.user)
				if len(assign) == 0:
					print("Manually entered number")
				else:
					print("Selected number")
					site.visit_assign_id = assign.first()
					assign_site = assign[0]
					assign_site.visited = True
					assign_site.save()

				site.save()

				return redirect("listassignedsites")
			else:
				messages.error(request, "Incorrect OTP")
				return redirect("addsite2")
		sentto = request.session['chosen_number']
		otp = request.session['current_otp']
		return render(request, 'addsite2.html', context={"sentto":sentto, "otp":otp})
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def listassignedsites(request):
	if not request.user.is_superuser and request.user.is_staff:
		#show pending visits
		pending = AssignedSite.objects.filter(visit_by=request.user, visited=False).order_by('-added_date')
		#show completed visits
		visited = AssignedSite.objects.filter(visit_by=request.user, visited=True).order_by('-added_date')
		#show manual visits
		# sites = Sites.objects.filter(user=request.user, visit_assign_id=None).order_by('-date')
		return render(request, 'listassignedsites.html', context={'pending':pending, 'visited':visited})
	return HttpResponse("<html><body>Unauthorized</body></html>")

    

@login_required(login_url='/login/')
def assignsite(request):
	if request.user.is_superuser:
		if request.method == "POST":
			form = AssignedSiteForm(request.POST)
			if form.is_valid():
				user = form.save()
				messages.success(request, "Site assigned successfully" )
				return redirect("assignsite")
			form = AssignedSiteForm(request.POST)
			messages.error(request, "Unsuccessful site assignment. Invalid information.")
			return render(request, 'assign_site.html', context={"site_form":form})
		form = AssignedSiteForm()
		return render(request, 'assign_site.html', context={"site_form":form})
	return HttpResponse("<html><body>Unauthorized</body></html>")


@login_required(login_url='/login/')
def siteotp(request, number):
	print(number)
	return redirect("listassignedsites")
	return render(request, 'site_otp.html')


@login_required(login_url='/login/')
def sitedetail(request):
	return render(request, 'site_detail.html')

@login_required(login_url='/login/')
def listsitevisits(request):
	context = {}
	sites = Sites.objects.order_by('-date')
	print(sites[0].visit_assign_id.id)
	context['sites'] = sites
	return render(request, 'list_site_visits.html', context)


@login_required(login_url='/login/')
def attendance(request):
	context = {}
	logs = WorkLog.objects.order_by('-date')
	context['logs'] = logs
	return render(request, 'attendance.html', context)

@login_required(login_url='/login/')
def monthattendance(request):
	context = {}
	logs = WorkLog.objects.order_by('-date')
	for l in logs:
		if l.logout == None:
			logout = datetime.strptime("18:30",'%H:%M')
		else:
			logout = datetime.strptime(l.logout.strftime("%H:%M"),'%H:%M')
		login = datetime.strptime(l.login.strftime("%H:%M"),'%H:%M')
		# login = datetime.strptime(l.login.strftime("%H:%M"), "%H:%M")
		# logout = logout_time
		print(type(l.login), l.login)
		print(type(l.logout), l.logout)
		print(type(login), login)
		print(type(logout), logout)
		x =  logout - login
		print(x)
		print("###")
	context['logs'] = logs
	return render(request, 'attendance.html', context)

@login_required(login_url='/login/')
def test(request):
	context = {}
	return render(request, 'test.html', context)

