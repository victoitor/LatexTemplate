# [Choice] Debian version (use bullseye on local arm64/Apple Silicon): trixie, bookworm, bullseye, buster
ARG VARIANT="stable"
ARG DIGEST="sha256:8b93ad76990ec65619f2d8f7cfaec9155330a083b182afdcca3b83a1d1c32fab"
FROM debian:${VARIANT}@${DIGEST}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>