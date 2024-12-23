# loghi.sls

install_docker:
  cmd.run:
    - name: |
        sudo apt-get remove -y docker docker-engine docker.io containerd runc

        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg

        sudo install -m 0755 -d /etc/apt/keyrings

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg

        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
        https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    - shell: /bin/bash

add_user_to_docker_group:
  cmd.run:
    - name: sudo usermod -aG docker $USER

install_nvidia_container_toolkit:
  cmd.run:
    - name: |
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /etc/apt/keyrings/nvidia-container-toolkit-keyring.gpg
        curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
          sed 's#deb [arch=amd64 signed-by=/etc/apt/keyrings/nvidia-container-toolkit-keyring.gpg]#deb [arch=amd64 signed-by=/etc/apt/keyrings/nvidia-container-toolkit-keyring.gpg]#g' | \
          sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
        sudo apt-get update
        sudo apt-get install -y nvidia-container-toolkit
        sudo systemctl restart docker
    - shell: /bin/bash

verify_nvidia_docker:
  cmd.run:
    - name: sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
    - shell: /bin/bash

pull_loghi_docker_images:
  cmd.run:
    - name: |
        sudo docker pull loghi/docker.laypa
        sudo docker pull loghi/docker.htr
        sudo docker pull loghi/docker.loghi-tooling
    - shell: /bin/bash

clone_loghi_repository:
  git.latest:
    - name: https://github.com/knaw-huc/loghi.git
    - target: /home/azureuser/loghi
    - user: azureuser
    - require:
      - cmd: install_docker

configure_inference_script:
  file.managed:
    - name: /home/azureuser/loghi/scripts/inference-pipeline.sh
    - source: salt://files/inference-pipeline.sh
    - user: azureuser
    - group: azureuser
    - mode: '0755'
