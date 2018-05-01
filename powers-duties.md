---
layout: page
title: Powers and duties
permalink: /powers-duties/
---

{% for item in site.powers-duties %}
  <h2>{{ item.title }}</h2>
  <p>{{ item.description }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}