from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.Index.as_view(), name='index'),
    url(r'^login', views.login, name='login'),
    url(r'^password_reset', views.password_reset, name='password_reset'),
]
