# Ansible

This image allows you to run Ansible from a container.


# Build

```bash
docker build -t ansible:1.0.0 .
```


# Run

Before running the container you need [to be authenticated](https://docs.gitlab.com/ee/user/packages/container_registry/#build-and-push-images-by-using-docker-commands) with the GitLab Container Registry.

Container has the following conventions:

* To provide SSH key to access target hosts, use `-v /path/to/key:/tmp/id_rsa`
* To provide password for Ansible Vault, use `-v /path/to/password/file:/tmp/pass`
* To provide Ansible code, use `-v /path/to/ansible/code:/ansible`

Examples:

```bash
docker run --rm -it \
    -v "$(pwd):/ansible" \
    -v "/root/.ssh/secret_key:/tmp/id_rsa" \
    wurdum/ansible ansible all -m ping

docker run --rm -it \
    -v "$(pwd):/ansible" \
    -v "/root/.ssh/secret_key:/tmp/id_rsa" \
    wurdum/ansible ansible-playbook ksqldb.yml

docker run --rm -it \
    -v "$(pwd):/ansible" \
    -v "$(pwd)/.vault-pass:/tmp/pass" \
    -v "/root/.ssh/secret_key:/tmp/id_rsa" \
    wurdum/ansible ansible-playbook lt.yml
```
