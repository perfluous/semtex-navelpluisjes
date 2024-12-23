# saltstack/salt/docker_images.sls

copy_docker_images:
  file.recurse:
    - name: {{ pillar.docker_images_dir }}
    - source: salt://files/docker_images/
    - user: {{ pillar.username }}
    - dir_mode: 755
    - file_mode: 644
    - require:
      - pkg: install_docker

load_docker_images:
  cmd.run:
    - name: |
        docker load -i {{ pillar['docker_images_dir'] }}/docker_htr.tar
        docker load -i {{ pillar['docker_images_dir'] }}/docker_laypa.tar
        docker load -i {{ pillar['docker_images_dir'] }}/docker_loghi_tooling.tar
    - runas: root
    - shell: /bin/bash
    - require:
      - file: copy_docker_images

remove_docker_tar_files:
  file.absent:
    - name: {{ pillar['docker_images_dir'] }}
    - require:
      - cmd: load_docker_images
