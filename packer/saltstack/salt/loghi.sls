# saltstack/salt/loghi.sls
create_navelpluisjes_directory:
  file.directory:
    - name: {{ pillar['navelpluisjes_dir'] }}
    - user: {{ pillar['username'] }}
    - group: {{ pillar['username'] }}
    - mode: 755

clone_loghi_repository:
  git.latest:
    - name: {{ pillar['loghi_repo_url'] }}
    - target: {{ pillar['navelpluisjes_dir'] }}/loghi
    - user: {{ pillar['username'] }}
    - require:
      - file: create_navelpluisjes_directory
