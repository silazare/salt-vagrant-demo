---
{% set users = pillar.get('users') %}

formula.common.install.packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      - vim
      - supervisor

{% for user, uid in users.items() %}
formula.common.install.{{user}}:
  user.present:
    - uid: {{uid}}
{% endfor %}
