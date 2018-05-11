---
layout: page
title: Services
permalink: /services/
---
{% assign services = site.services | where: "internal", false %}

{{ services | size }}

{% for item in services %}
  <h2>{{ item.title }}</h2>
  <p>{{ item.description }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}