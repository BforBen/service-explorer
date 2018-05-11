---
layout: page
title: Functions
permalink: /functions/
---
{% assign functions = site.functions | where: parent_id, "" %}
{% for item in functions  %}
  <h2>{{ item.title }}</h2>
  <p>{{ item.description }}</p>
  <p><a href="{{ item.url }}">{{ item.title }}</a></p>
{% endfor %}