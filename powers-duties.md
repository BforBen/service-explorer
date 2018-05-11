---
layout: page
title: Powers and duties
permalink: /powers-duties/
---
{% assign powers = site.powers-duties | where: parent_id.size, 0 %}
{% for item in powers %}
  <h2>{{ item.title }}</h2>
  <p>{{ item.description }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}