from django.shortcuts import render,redirect
from django.views.generic.list import ListView
from .models import Picture

# Create your views here.
def about(request):
    return render(request, 'info/about.html', {})

def contact(request):
    return render(request, 'info/contact.html', {})

class Gallery(ListView):
    model = Picture
    order_by = '-uploaded_on'
    template_name = 'info/gallery.html'
    context_object_name = 'images'
    paginate_by = 3

def gallery_img(request,pk):
    return redirect(Picture.objects.get(pk=pk).path.url)

def register_message(request):
    return render(request, "info/register.html", {})
