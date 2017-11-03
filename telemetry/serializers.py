from rest_framework import serializers

from .models import *

class PingEntrySerializer(serializers.ModelSerializer):
    class Meta:
        model = PingEntry
        fields = "__all__"

class PingEntryNoIpSerializer(serializers.ModelSerializer):
    class Meta:
        model = PingEntry
        fields = ("servername","uptime")
