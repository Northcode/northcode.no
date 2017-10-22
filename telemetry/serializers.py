from rest_framework import serializers

from .models import *

class PingEntrySerializer(serializers.ModelSerializer):
    class Meta:
        model = PingEntry
        fields = ("servername","ipaddress","uptime")

class PingEntryNoIpSerializer(serializers.ModelSerializer):
    class Meta:
        model = PingEntry
        fields = ("servername","uptime")
