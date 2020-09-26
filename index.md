---
layout: home
---

## Hello

What's going on here?

I'm making a racing strategy game called <a href="/racing-game/">Mikey's Racing Game</a>

<h2 id="blog">Blog</h2>

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>