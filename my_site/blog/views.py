from django.shortcuts import render, get_object_or_404
from django.views.generic import ListView, DetailView
from django.views import View
from .models import Post, Author, Tag

class StartingPageView(ListView):
    model = Post
    template_name = "blog/index.html"
    context_object_name = "posts"
    ordering = ["-date"]

    def get_queryset(self):
        queryset = super().get_queryset()
        return queryset[:3]


class AllPostsView(ListView):
    model = Post
    template_name = "blog/post_list.html"
    context_object_name = "all_posts"
    ordering = ["-date"]


class PostDetailView(DetailView):
    model = Post
    template_name = "blog/post_detail.html"
    context_object_name = "post"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Pass tags in context (optional, since post.tags.all() works in templates)
        context["post_tags"] = self.object.tags.all()
        return context


class AuthorsListView(ListView):
    model = Author
    template_name = "blog/authors_list.html"
    context_object_name = "authors"


class AuthorDetailView(DetailView):
    model = Author
    template_name = "blog/author_detail.html"
    context_object_name = "author"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Pass author's posts ordered by date descending
        context["author_posts"] = self.object.posts.all().order_by("-date")
        return context


class TagsListView(ListView):
    model = Tag
    template_name = "blog/tag_list.html"
    context_object_name = "tags"


class TagPostsView(ListView):
    model = Post
    template_name = "blog/tag_post.html"
    context_object_name = "posts"

    def get_queryset(self):
        tag_caption = self.kwargs["tag_caption"]
        # Filter posts that have the tag caption case-insensitively
        return Post.objects.filter(tags__caption__iexact=tag_caption).order_by("-date")

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["tag_name"] = self.kwargs["tag_caption"]
        return context


def custom_404_view(request, exception=None):
    """
    Custom 404 handler.
    Renders the custom 404 template with status code 404.
    """
    return render(request, "404.html", status=404)
