FROM paketobuildpacks/build-jammy-base:latest

USER root
RUN apt-get update && apt-get install -y jq git && \
    rm -rf /var/lib/apt/lists/*

# ARG IMGPKG_VERSION=0.39.0
# RUN url=https://github.com/vmware-tanzu/carvel-imgpkg/releases/download/v${IMGPKG_VERSION}/imgpkg-linux-amd64; \
#     curl -sSL $url -o /usr/local/bin/imgpkg && \
#     chmod +x /usr/local/bin/imgpkg
RUN curl -L https://carvel.dev/install.sh | K14SIO_INSTALL_BIN_DIR=/usr/local/bin bash
