from django.shortcuts import render
from django.http import HttpResponse

from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from rest_framework.authentication import BasicAuthentication, SessionAuthentication

from .models import *
from .serializers import *

from ipware.ip import get_ip


# Create your views here.
@api_view(['GET'])
@authentication_classes([BasicAuthentication, SessionAuthentication])
@permission_classes([IsAuthenticated])
def get_user_token(request):
    user = request.user
    tokens = Token.objects.filter(user=user)
    if tokens.count() > 0:
        token = tokens[0]
    else:
        token = Token.objects.create(user=user)
    return Response({ "token": str(token) })


@api_view(['POST'])
def register_entry(request):
    ip = get_ip(request)
    serializer = PingEntryNoIpSerializer(data=request.data)
    if ip is not None and serializer.is_valid():
        servername = serializer.validated_data["servername"]
        uptime = serializer.validated_data["uptime"]
        entry = PingEntry(servername=servername, ipaddress=ip, uptime=uptime)
        entry.save()
        return HttpResponse("request registered")
    else:
        return HttpResponse("ip not found")


class PingEntryViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = PingEntry.objects.all()
    serializer_class = PingEntrySerializer
    
