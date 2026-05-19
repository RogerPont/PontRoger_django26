from django.urls import path
from . import views

urlpatterns = [
    path("", views.StartingPageView.as_view(), name="starting-page"),
    path("posts", views.AllPostsView.as_view(), name="posts-page"),
    path("posts/<slug:slug>", views.PostDetailView.as_view(), name="post-detail-page"),
    path("authors", views.AuthorsListView.as_view(), name="authors-page"),
    path("authors/<int:pk>", views.AuthorDetailView.as_view(), name="author-detail-page"),
    path("tags", views.TagsListView.as_view(), name="tags-page"),
    path("tags/<str:tag_caption>", views.TagPostsView.as_view(), name="tag-posts-page"),
]
