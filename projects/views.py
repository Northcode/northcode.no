from django.shortcuts import render
from django.views.generic.list import ListView

from .models import Project

# Create your views here.

class Projects(ListView):
    template_name = 'projects/projects.html'
    context_object_name = 'projects'

    def get_queryset(self):
        return Project.objects.order_by('pk')
