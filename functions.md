---
layout: page
title: Functions
permalink: /functions/
---

{% for item in site.functions %}
  <h2>{{ item.title }}</h2>
  <p>{{ item.description }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}