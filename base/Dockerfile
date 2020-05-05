FROM registry.svc.ci.openshift.org/origin/4.4:machine-config-daemon as mcd
FROM registry.svc.ci.openshift.org/origin/4.4:artifacts as artifacts

FROM docker.io/centos:8
RUN yum update -y

# Latest podman
RUN dnf -y module disable container-tools && \
    dnf -y install 'dnf-command(copr)' && \
    dnf -y copr enable rhcontainerbot/container-selinux && \
    curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/CentOS_8/devel:kubic:libcontainers:stable.repo && \
    dnf -y install podman

# CRIO
RUN  dnf -y copr enable rhcontainerbot/container-selinux && \
     curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable:cri-o:1.17.repo https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:1.17/CentOS_8/devel:kubic:libcontainers:stable:cri-o:1.17.repo && \
     dnf -y install cri-o

# Hyperkube and oc
COPY --from=artifacts /srv/repo/*.rpm /tmp/rpms/
RUN dnf install -y /tmp/rpms/*.rpm

COPY --from=mcd /usr/bin/machine-config-daemon /usr/bin/machine-config-daemon

CMD [ "/sbin/init" ]
