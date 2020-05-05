#!/bin/bash -eux

# TODO:
# openshift-install create ignition-manifest --output=cluster

# TODO: MCD won't accept ign, has to be converted into MC

sudo podman build -t localhost/okd/4.4:base . -f base/Dockerfile

for TYPE in {bootstrap,master,worker}; do
  sudo podman build \
    --build-arg=TYPE=${TYPE} \
    -v $(pwd)/cluster:/cluster \
    -t localhost/okd/4.4:${TYPE} . -f node/Dockerfile
done

sudo podman run \
   --name=bootstrap \
   --rm \
   --privileged \
   --network=slirp4netns \
   --systemd=true \
   -v ~/foo:/var/lib/containers/storage \
   -ti localhost/okd/4.4:bootstrap
