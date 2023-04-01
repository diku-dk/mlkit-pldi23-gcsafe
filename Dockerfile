FROM debian:bullseye-slim
LABEL description="Artifact for the paper *Garbage-Collection Safety for Region-Based Type-Polymorphic Programs* submitted to PLDI 2023"

# Install tools
RUN apt-get update
RUN apt-get install -y sudo make gcc libgmp-dev time automake patch git bsdextrautils

# Clean up image.
RUN apt-get clean autoclean
RUN apt-get autoremove --yes
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

# Set up user
RUN adduser --gecos '' --disabled-password bench
RUN echo "bench ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers
USER bench
WORKDIR /home/bench/

# Install MLton
ADD --chown=bench https://github.com/MLton/mlton/releases/download/on-20210117-release/mlton-20210117-1.amd64-linux-glibc2.31.tgz ./
RUN tar xf mlton-20210117-1.amd64-linux-glibc2.31.tgz
RUN make -C mlton-20210117-1.amd64-linux-glibc2.31 install PREFIX=/home/bench/mlton
ENV PATH=/home/bench/mlton/bin:$PATH
RUN rm -rf mlton-20210117-1.amd64-linux-glibc2.31*

# Install MLKit
ADD --chown=bench https://github.com/melsman/mlkit/releases/download/v4.7.3/mlkit-bin-dist-linux.tgz ./
RUN tar xf mlkit-bin-dist-linux.tgz
RUN make -C mlkit-bin-dist-linux install PREFIX=/home/bench/mlkit
ENV PATH=/home/bench/mlkit/bin:$PATH
ENV SML_LIB=/home/bench/mlkit/lib/mlkit
RUN rm -rf mlkit-bin-dist-linux*

WORKDIR /home/bench

# Copy artifact files into image.
RUN mkdir mlkit-pldi23-gcsafe
COPY --chown=bench ./ mlkit-pldi23-gcsafe/

WORKDIR /home/bench/mlkit-pldi23-gcsafe

# Install MLKit src
ADD --chown=bench https://github.com/melsman/mlkit/archive/refs/tags/v4.7.3.tar.gz ./
RUN tar xf v4.7.3.tar.gz
RUN rm -f v4.7.3.tar.gz

CMD bash
