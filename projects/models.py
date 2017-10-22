from django.db import models

# Create your models here.
class Project(models.Model):
    name = models.CharField(max_length=50)
    git_link = models.CharField(max_length=500)
    description = models.CharField(max_length=100)
    text = models.TextField()

    def __str__(self):
        return self.name
