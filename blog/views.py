from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from .models import Post

# Create your views here.
class Index(ListView):
	template_name = 'blog/index.html'
	context_object_name = 'blog_posts'

	def get_queryset(self):
		return Post.objects.order_by('-posted')[:5]

class BlogPost(DetailView):
	model = Post
	template_name = 'blog/post.html'
	context_object_name = 'post'
