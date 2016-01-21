from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^about', views.about, name="about"),
    url(r"^contact", views.contact, name="contact"),
    url(r"^gallery/$", views.Gallery.as_view(), name="gallery"),
    url(r"^gallery/(?P<pk>\d+)/$", views.gallery_img, name="gallery_img"),
]
