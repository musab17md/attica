from rest_framework import serializers

from logins.models import AssignedSite, WorkLog, Sites

class WorkLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = WorkLog
        fields = '__all__'

class SiteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sites
        fields = '__all__'

class AssignedSiteSerializer(serializers.ModelSerializer):
    class Meta:
        model = AssignedSite
        fields = ['name', 'number', 'address']