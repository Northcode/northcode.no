from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.Index.as_view(), name='index'),
    url(r'^login', 'django.contrib.auth.views.login', { 'template_name': 'blog/login.html', 'redirect_field_name':'next' } , name='login'),
    url(r'^logout', 'django.contrib.auth.views.logout', { 'next_page': 'index' } , name='logout'),
    url(r'^password_reset', views.password_reset, name='password_reset'),
]
