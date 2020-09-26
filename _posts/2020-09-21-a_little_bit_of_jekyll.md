---
layout: post
title: "A Little Bit of Jekyll"
date: 2020-09-21 20:00:00 -0500
---
Since I'm hosting this site on <a href="https://pages.github.com/">GitHub Pages</a>,
it seemed sensible as a first step to get the blog aspect of the site running
well using Jekyll.

First I needed to get Jekyll running locally. So I installed some software:

{% highlight sh %}
sudo apt install ruby ruby-dev ruby-bundler zlib1g-dev
sudo gem install jekyll
{% endhighlight %}

Then it was time to get Jekyll really moving. So from in the project folder:

{% highlight sh %}
jekyll new . --force
{% endhighlight %}

Then modify the `Gemfile` to use `github-pages` gem instead of `jekyll`. I also
commented out the theme gem because I want to start from scratch with my CSS. 

{% highlight ruby %}
# Happy Jekylling!
# gem "jekyll", "~> 4.1.1"
# This is the default theme for new Jekyll sites. You may change this to anything you like.
# gem "minima", "~> 2.5"
# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
gem "github-pages", group: :jekyll_plugins
{% endhighlight %}

Then time to update the gems and try things out.

{% highlight sh %}
bundle update
bundle exec jekyll serve
{% endhighlight %}

Open a browser pointed at `http://127.0.0.1:4000` and make sure it looks like anything at all.

Now it's time to take full control of the template process. Create a `_layouts` folder with 
a `default.html` file inside. My initial default layout is pretty sparse for now:
{% highlight html %}
{% raw %}
<!DOCTYPE html>
<html>

<head>
    <title>{{ page.title }} @ Mikey's Games</title>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
    <link rel='stylesheet' type='text/css' href='/css/site.css'>
</head>

<body>
    <h1><a href="/">{{ site.title }}</a> / {{ page.title }}</h1>
    {{ content }}
</body>

</html>
{% endraw %}
{% endhighlight %}

Then I borrowed a little CSS from existing Jekyll themes to make the code snippets on this page actually halfway readable... and I think that's the bulk of what I needed to do to Jekyll-ify the site.

Now that the site is at a bare minimum useful state for blogging I can start working on my first game, 
<a href="/formulax/">Formula X</a>.