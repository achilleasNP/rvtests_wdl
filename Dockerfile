FROM debian:stable-20191014-slim
RUN apt-get update && apt-get install -y \
                                       git \
                                       build-essential \ 
                                       wget \  
                                       gfortran \
                                       unzip \
                                       zlib1g-dev \
                                       liblzma-dev \
                                       liblz-dev
RUN useradd --system \
            --create-home \
            --home-dir /home/debian \
            --shell /bin/bash  \
            --gid root \
            --groups sudo \
            --uid 1000 \
            debian

USER debian
WORKDIR /home/debian
RUN git clone https://github.com/zhanxw/rvtests && cd rvtests && git checkout v2.1.0 && make
ENV PATH="${PATH}:/home/debian/rvtests/executable/"
WORKDIR /home/debian
CMD "/bin/bash"
