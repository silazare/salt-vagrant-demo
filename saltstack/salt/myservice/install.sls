---
{% set myservice = pillar.get('myservice') %}

{% for dir_name, dir_path in myservice.dirs.items() %}
formula.myservice.dir.{{ dir_name }}:
  file.directory:
    - name: {{ dir_path }}
    - mode: "0755"
    - makedirs: True
{% endfor %}

formula.myservice.install.script:
  file.managed:
    - name: "{{ myservice.dirs.home }}/myservice.py"
    - source: salt://myservice/templates/myservice.py
    - mode: "0755"
    - watch_in:
      - service: formula.myservice.supervisor.service.start

formula.myservice.install.config:
  file.managed:
    - name: "{{ myservice.dirs.home }}/myservice.yaml"
    - source: salt://myservice/templates/myservice.yaml.j2
    - mode: "0664"
    - template: jinja
    - context:
       myservice: {{ myservice | tojson }}
    - watch_in:
      - service: formula.myservice.supervisor.service.start
