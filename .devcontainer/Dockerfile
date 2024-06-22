FROM google/dart:2.15
RUN apt-get update && apt-get install -y curl unzip
RUN curl -sL https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_2.8.0-stable.tar.xz | tar xJ -C /usr/local
ENV PATH="/usr/local/flutter/bin:${PATH}"
