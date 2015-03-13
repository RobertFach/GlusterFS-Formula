{% "glusterfs/map.jinja" import glusterfs with context %}

glusterfs-server:
    pkg.installed:
        - name: {{ glusterfs['glusterfs-server'] }}
    service.running:
        - enable: True
        - name: {{ salt.get('glusterfs-server-service', 'glusterfs-server') }}
        - watch:
            - pkg: glusterfs-server
