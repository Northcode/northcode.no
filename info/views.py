from django.shortcuts import render,redirect
from django.views.generic.list import ListView
from .models import Picture

# Create your views here.
def about(request):
    return render(request, 'info/about.html', {})

def contact(request):
    return render(request, 'info/contact.html', {})

class Gallery(ListView):
    template_name = 'info/gallery.html'
    context_object_name = 'images'

    def get_queryset(self):
        return Picture.objects.order_by('-uploaded_on')[:3]

def gallery_img(request,pk):
    return redirect(Picture.objects.get(pk=pk).path.url)
