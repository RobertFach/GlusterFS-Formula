{% from 'glusterfs/map.jinja' import glusterfs with context %}

{% set brickpath = salt['pillar.get']('glusterfs:lookup:brickpath', '/export/gluster/brick0') %}
{% set peers = salt['pillar.get']('glusterfs:lookup:peers', []) %}
{% set volumename = salt['pillar.get']('glusterfs:lookup:volumename', 'myvolume') %}
{% set startvolume = salt['pillar.get']('glusterfs:lookup:startvolume', False) %}
{% set replicas = salt['pillar.get']('glusterfs:lookup:replicas', 0) %}

peer clusterfs nodes:
    glusterfs.peered:
        - names:
          {% for peer in peers %}
          - {{ peer }}
          {% endfor %}

{{ volumename }}:
    glusterfs.created:
        - bricks:
            {% for peer in peers %}
            - {{ peer }}:{{ brickpath }}
            {% endfor %}
        - start: {{ startvolume }}
        {% if replicas > 0 %}
        - replica: {{ replicas }}
        {% endif %}
