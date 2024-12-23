# saltstack/salt/docker.sls

install_required_packages:
  pkg.installed:
    - pkgs:
      - wget
      - curl
      - git
      - ca-certificates
      - gpg2
      - lsb-release
      - kernel-default-devel
      - parted
      - gdisk
      - e2fsprogs
      - systemd
      - open-iscsi
      - tpm2.0-tools
      - rng-tools
      - lvm2
      - mdadm
      - cifs-utils
      - rpcbind
      - squashfuse-tools

install_docker:
  pkg.installed:
    - name: docker

start_and_enable_docker:
  service.running:
    - name: docker
    - enable: True

add_user_to_docker_group:
  user.mod:
    - name: {{ pillar.username }}
    - groups:
        - docker
    - append: True
    - require:
        - pkg: install_docker

