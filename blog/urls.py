from django.conf.urls import url
from django.contrib.auth.views import login, logout

from . import views

urlpatterns = [
    url(r'^$', views.Index.as_view(), name='index'),
    url(r'^login', login, { 'template_name': 'blog/login.html', 'redirect_field_name':'next' } , name='login'),
    url(r'^logout', logout, { 'next_page': 'index' } , name='logout'),
]
