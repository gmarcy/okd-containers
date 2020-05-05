FROM okd/4.4:base

ARG TYPE=bootstrap

VOLUME /cluster

RUN machine-config-daemon start \
    --node-name $(hostname) \
    --once-from /cluster/${TYPE}.yaml \
    --root-mount=/ \
    --skip-reboot

# FIXME: OKD's bootkube wants to disable zincati
RUN cp -rvf /etc/systemd/system/{progress,zincati}.service
