from django.db import models
from django.contrib.auth.models import User
from django_markdown.models import MarkdownField

# Create your models here.
class PostTag(models.Model):
    tagname = models.CharField(max_length=15)

    def __str__(self):
        return self.tagname

class Post(models.Model):
    title = models.CharField(max_length=50)
    text = MarkdownField()
    author = models.ForeignKey(User,on_delete=models.SET_NULL,null=True)
    posted = models.DateTimeField(auto_now_add=True)
    tags = models.ManyToManyField(PostTag)

    def __str__(self):
        return self.title
    
