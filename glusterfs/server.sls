{% from 'glusterfs/map.jinja' import glusterfs with context %}

{% set brick_path = salt['pillar.get']('glusterfs:lookup:brick_path') %}
{% set host1 = salt['pillar.get']('glusterfs:lookup:host1') %}
{% set host2 = salt['pillar.get']('glusterfs:lookup:host2') %}

glusterfs-server:
    pkg.installed:
        - name: {{ glusterfs.package }}
    service.running:
        - enable: True
        - name: {{ glusterfs.service }}
        - watch:
            - pkg: glusterfs-server


{{ brick_path }}:
    file.directory:
        - user: root
        - group: root

{% if salt['pillar.get']('glusterfs:lookup:role') == 'primary' %}
myvolume:
    glusterfs.created:
        - bricks:
            - {{ host1 }}:{{ brick_path }}
            - {{ host2 }}:{{ brick_path }}
{% endif %}
