FROM openjdk:8-jdk-alpine

# Install build packages
RUN apk add --no-cache \
    curl \
    wget \
    unzip \
    bash

# Download the latest release of WoWChat-Turtle
RUN curl -s https://api.github.com/repos/Skeewirt/WoWChat-Turtle/releases/latest | \
    grep "browser_download_url.*zip" | \
    cut -d '"' -f 4 | \
    wget -qi -

# Unzip the downloaded file
RUN unzip wowchat-*.zip && \
    rm wowchat-*.zip && \
    mv wowchat/* ./ && \
    rm -R wowchat/

# Remove build packages to clean up image
RUN apk del \
    curl \
    wget \
    unzip

ENTRYPOINT ["bash","run.sh"]
