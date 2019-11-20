# Base distribution
FROM debian:stable-20191014-slim

# Get dependencies
RUN apt-get update && apt-get install -y \
                                       git \
                                       build-essential \ 
                                       wget \  
                                       gfortran \
                                       unzip \
                                       zlib1g-dev \
                                       liblzma-dev \
                                       liblz-dev
# Add debian user
RUN useradd --system \
            --create-home \
            --home-dir /home/debian \
            --shell /bin/bash  \
            --gid root \
            --groups sudo \
            --uid 1000 \
            debian

# INSTALL rvtests under opt
WORKDIR /opt
RUN git clone https://github.com/zhanxw/rvtests && cd rvtests && git checkout v2.1.0 && make

## Set permissions  
RUN chmod o+rx rvtests rvtests/executable
WORKDIR /opt/rvtests/executable
RUN find .| grep -v '\.d' | xargs -I{} chmod o+rx '{}'   


# Do rvtests installation as user debian
USER debian
WORKDIR /home/debian

# Add executables to PATH
ENV PATH="${PATH}:/opt/rvtests/executable"
CMD "/bin/bash"
