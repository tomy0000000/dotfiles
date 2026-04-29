# `ansible`

Deploys Ansible configuration and a starter inventory file into `$HOME`.

## Installs

This package does not install Ansible — it only manages configuration. Install
Ansible separately (e.g. `pip install ansible` or via your OS package manager).

## Configures

- `~/.ansible.cfg` (stow) — sets `inventory = ~/.ansible/hosts`,
  `gathering = explicit`, and `nocows = True`
- `~/.ansible/hosts` (stow) — starter inventory template with a placeholder
  group and default `ansible_user` / `ansible_python_interpreter` vars

## Notes

- Edit `~/.ansible/hosts` to replace the `name`/`ip.or.hostname` placeholder
  with real hosts before running any playbooks.
- `gathering = explicit` means facts are only collected when explicitly
  requested, which speeds up playbook runs.
