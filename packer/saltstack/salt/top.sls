# saltstack/salt/top.sls

base:
  '*':
    - system
    - docker
    - docker_images
    - loghi
    - permissions
    - cleanup
