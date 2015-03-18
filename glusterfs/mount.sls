{% from 'glusterfs/map.jinja' import glusterfs with context %}

{% set peers = salt['pillar.get']('glusterfs:lookup:peers', []) %}
{% set volumename = salt['pillar.get']('glusterfs:lookup:volumename', 'myvolume') %}
{% set mountpoint = salt['pillar.get']('glusterfs:lookup:mountpoint', '') %}

make sure nfs packages are installed:
    pkg.installed:
        - name: nfs-common

{% if mountpoint != '' and peers|length() > 0 %}

{{ mountpoint }}:
    mount.mounted:
        - device: {{ peers[0] }}:/{{ volumename }}
        - fstype: nfs
        - persist: True
        - mkmnt: True
        - opts: proto=tcp,vers=3
{% endif %}

