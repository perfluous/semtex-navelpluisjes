# saltstack/salt/permissions.sls

set_executable_permissions:
  file.recurse:
    - name: {{ pillar.navelpluisjes_dir }}
    - user: {{ pillar.username }}
    - group: {{ pillar.username }}
    - dir_mode: 755
    - file_mode: 755

ensure_scripts_executable:
  file.directory:
    - name: {{ pillar.navelpluisjes_dir }}/loghi/scripts
    - recurse:
        - user
        - group
        - mode
    - file_mode: 755
    - dir_mode: 755
    - user: {{ pillar.username }}
    - group: {{ pillar.username }}
    - require:
        - git: clone_loghi_repository
