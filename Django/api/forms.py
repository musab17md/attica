from django import forms

from .models import *


class PicsForm(forms.ModelForm):
    class Meta:
        model = Pics2
        fields = '__all__'