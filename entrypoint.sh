#!/bin/sh
set -e

if [ -f /tmp/id_rsa ]; then
    echo "SSH key for Ansible is provided"

    mkdir ~/.ssh
    cp /tmp/id_rsa ~/.ssh/
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_rsa
fi

if [ -f /tmp/pass ]; then
    echo "Ansible Vault password file is provided"

    cp /tmp/pass ~/.ansible_vault_pass
    chmod 400 ~/.ansible_vault_pass

    export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault_pass
fi

exec "$@"
