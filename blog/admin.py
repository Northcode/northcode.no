from django.contrib import admin
from blog.models import Post,PostTag

# Register your models here.
admin.site.register(Post)
admin.site.register(PostTag)

