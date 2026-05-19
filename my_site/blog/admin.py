from django.contrib import admin
from .models import Author, Tag, Post

class PostAdmin(admin.ModelAdmin):
    list_filter = ("author", "tags", "date",)
    list_display = ("title", "date", "author",)
    search_fields = ("title", "content",)
    prepopulated_fields = {"slug": ("title",)}

class AuthorAdmin(admin.ModelAdmin):
    list_display = ("first_name", "last_name", "email_address",)
    search_fields = ("first_name", "last_name", "email_address",)

admin.site.register(Author, AuthorAdmin)
admin.site.register(Tag)
admin.site.register(Post, PostAdmin)
