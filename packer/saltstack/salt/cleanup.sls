# saltstack/salt/cleanup.sls

clean_package_caches:
  cmd.run:
    - name: sudo zypper clean --all

remove_temporary_files:
  file.absent:
    - name: /tmp
  file.absent:
    - name: /var/tmp

truncate_log_files:
  cmd.run:
    - name: find /var/log -type f -exec truncate -s 0 {} \;

remove_temporary_files:
  file.directory:
    - name: /tmp
    - clean: True
  file.directory:
    - name: /var/tmp
    - clean: True


zero_out_free_space:
  cmd.run:
    - name: |
        dd if=/dev/zero of=/EMPTY bs=1M || echo "No free space left to zero."
        rm -f /EMPTY

clear_shell_history:
  file.absent:
    - name: {{ pillar['user_home'] }}/.bash_history
  file.absent:
    - name: /root/.bash_history
