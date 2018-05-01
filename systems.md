---
layout: page
title: Systems
permalink: /systems/
---

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
      <th>On premise?</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
{% for item in site.systems %}
    <tr>
      <td>{{ item.title }}</td>
      <td>{{ item.description }}</td>
      <td>{{ item.on_premise }}</td>
      <td><a href="{{ item.url }}">More information</a></td>
    </tr>
{% endfor %}
  </tbody>
</table>