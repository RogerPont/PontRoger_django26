from django.db import models
from django.core.validators import MinLengthValidator

class Author(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email_address = models.EmailField()

    def get_post_count(self):
        """
        Returns the number of posts published by this author.
        This is a project requirement for the video presentation.
        """
        return self.posts.count()

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class Tag(models.Model):
    caption = models.CharField(max_length=50)

    def __str__(self):
        return self.caption


class Post(models.Model):
    title = models.CharField(max_length=150)
    excerpt = models.CharField(max_length=200, validators=[MinLengthValidator(10)])
    image_name = models.CharField(max_length=100)
    date = models.DateField(auto_now=True)
    slug = models.SlugField(unique=True, db_index=True)
    content = models.TextField(validators=[MinLengthValidator(10)])
    
    # Relationships
    author = models.ForeignKey(
        Author, 
        on_delete=models.CASCADE, 
        related_name="posts"
    )
    tags = models.ManyToManyField(
        Tag, 
        related_name="posts", 
        blank=True
    )

    def __str__(self):
        return self.title
