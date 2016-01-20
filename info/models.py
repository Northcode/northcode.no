from django.db import models

from easy_thumbnails.signals import saved_file
from easy_thumbnails.signal_handlers import generate_aliases_global

# Create your models here.
class Picture(models.Model):
    title = models.CharField(max_length=80)
    path = models.ImageField(upload_to="gallery/")
    uploaded_on = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

saved_file.connect(generate_aliases_global)
