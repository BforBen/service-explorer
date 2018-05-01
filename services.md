---
layout: page
title: Services
permalink: /services/
---

{{ site.services | size }}

{% for item in site.services %}
  <h2>{{ item.title }}</h2>
  <p>{{ item.description }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}