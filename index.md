---
layout: home
---

## Hello

What's going on here?

My family and I are writing some web-based games that you run on
your own computer/TV and everyone plays from a smartphone or tablet

<h2 id="blog">Blog</h2>

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>