from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.Projects.as_view(), name="projects"),
    url(r"^(?P<pk>\d+)/$", views.ProjectDetail.as_view(), name="project"),
]
