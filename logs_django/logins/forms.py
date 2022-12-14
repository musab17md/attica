from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from logins.models import Profile, WorkLog, Sites, AssignedSite
from django.db import models


# Create your forms here.

class NewUserForm(UserCreationForm):
	first_name = forms.CharField(required=True)
	last_name = forms.CharField(required=True)
	email = forms.EmailField(required=True)

	class Meta:
		model = User
		fields = ("username", "first_name", "last_name", "email", "password1", "password2")

	def save(self, commit=True):
		user = super(NewUserForm, self).save(commit=False)
		user.email = self.cleaned_data['email']
		if commit:
			user.save()
		return user


class WorkLogForm(forms.ModelForm):
	class Meta:
		model = WorkLog
		fields = '__all__'


class SitesForm(forms.ModelForm): #filter visit_by to show only to same user
	class Meta:
		model = Sites
		fields = ("place", "number", "comment")


class AssignedSiteForm(forms.ModelForm):
	class Meta:
		model = AssignedSite
		fields = '__all__'




class ProfileForm(forms.ModelForm):
	class Meta:
		model = Profile
		fields = '__all__'

# class SiteForm1(forms.Form):
# 	select_a_number = forms.ChoiceField(choices=[['','']])
# 	or_enter_number_manually = forms.CharField()

