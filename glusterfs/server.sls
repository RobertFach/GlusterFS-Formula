{% from "glusterfs/map.jinja" import glusterfs with context %}

glusterfs-server:
    pkg.installed:
        - name: {{ glusterfs.package }}
    service.running:
        - enable: True
        - name: {{ glusterfs.service }}
        - watch:
            - pkg: glusterfs-server
