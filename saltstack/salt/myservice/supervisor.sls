---
{% set myservice = pillar.get('myservice') %}

formula.myservice.supervisor.config:
  file.managed:
    - name: /etc/supervisor/conf.d/myservice.conf
    - source: salt://myservice/templates/supervisord.conf.j2
    - mode: "0664"
    - template: jinja
    - context:
       myservice: {{ myservice | tojson }}
    - watch_in:
      - service: formula.myservice.supervisor.service.start

formula.myservice.supervisor.service.start:
  service.running:
    - name: supervisor
    - enable: True
