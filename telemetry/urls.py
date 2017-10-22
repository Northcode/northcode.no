from django.conf.urls import url
from django.contrib.auth.views import login, logout

from . import views

from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(r"pingentry", views.PingEntryViewSet)

urlpatterns = [
    url(r"^register", views.register_entry),
] + router.urls
