from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from .models import Post
from .forms import PostForm



# Create your views here.
class Index(ListView):
        template_name = 'blog/index.html'
        context_object_name = 'blog_posts'
        paginate_by = 5

        def get_queryset(self):
                return Post.objects.order_by('-posted')

class BlogPost(DetailView):
        model = Post
        template_name = 'blog/post.html'
        context_object_name = 'post'

def save_post(form,user):
        if form.is_valid():
                post = form.save(commit=False)
                post.author = user
                post.save()

                return redirect("blogpost", pk=post.pk)
        else:
                return HttpResponse(400, "no")

def new_post(request):
        if request.user.is_authenticated():
            if request.method == "GET":
                    form = PostForm()
                    return render(request, "blog/new_post.html", {
                            "form" : form
                    })
            else:
                    return save_post(PostForm(request.POST), request.user)
        else:
                return redirect("index")

def edit_post(request, pk):
        if request.user.is_authenticated():
                if request.method == "GET":
                        post = Post.objects.get(pk=pk)
                        form = PostForm(instance=post)
                        return render(request, "blog/new_post.html", { "form": form })
                else:
                        return save_post(PostForm(request.POST), request.user)
        else:
                return redirect("index")
