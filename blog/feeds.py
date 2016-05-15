from django.contrib.syndication.views import Feed
from django.core.urlresolvers import reverse
from .models import Post
from django_markdown.utils import markdown

class BlogFeed(Feed):
    title = "Northcode blog"
    link = "/rss/"
    description = "I write about stuff some times, it goes here."

    def items(self):
        return Post.objects.order_by('-posted')[:5]

    def item_title(self, item):
        return item.title

    def item_description(self, item):
        return markdown(item.text)

    def item_link(self, item):
        return reverse('blogpost', args=[item.pk])
