---
layout: home
---
## Hello

What's going on here?

I'm making a racing strategy game called [Formula X](/formulax)

## Blog Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>