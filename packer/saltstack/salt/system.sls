# saltstack/salt/system.sls

update_system:
  pkg.uptodate:
    - refresh: True
