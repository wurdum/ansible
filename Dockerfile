FROM ubuntu:22.04

ARG ANSIBLE_CORE_VERSION_ARG=6.3.0
ARG ANSIBLE_LINT=6.5.1
ENV ANSIBLE_LINT=${ANSIBLE_LINT}
ENV ANSIBLE_CORE=${ANSIBLE_CORE_VERSION_ARG}

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y gnupg2 python3-pip sshpass git openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN python3 -m pip install --upgrade pip cffi && \
    pip install ansible==${ANSIBLE_CORE} && \
    pip install ansible-lint==${ANSIBLE_LINT} && \
    pip install boto3 && \
    pip install botocore && \
    rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENV ANSIBLE_CONFIG=/ansible

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

WORKDIR /ansible

ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["ansible-playbook", "--version"]
