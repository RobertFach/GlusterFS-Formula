{% from 'glusterfs/map.jinja' import glusterfs with context %}

{% set brickpath = salt['pillar.get']('glusterfs:lookup:brickpath', '/export/gluster/brick0') %}
 
make sure filesystem extended attrib tools is installed:
    pkg.installed:
        - name: attr

remove bricks:
    cmd.run:
        - name: setfattr -x trusted.glusterfs.volume-id {{ brickpath }}
        - onlyif: attr -g trusted.glusterfs.volume-id {{ brickpath }} 
