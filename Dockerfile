FROM cntrump/ubuntu-toolchains:20.04 AS builder

RUN apt-get update && apt-get install libboost-system-dev libboost-program-options-dev -y

RUN git clone -b v1.15.1 --depth=1 https://github.com/trojan-gfw/trojan.git \
    && cd ./trojan && mkdir build && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DENABLE_MYSQL=OFF -DSYSTEMD_SERVICE=OFF \
             .. \
    && make && make install

RUN ldd /usr/local/bin/trojan

FROM cntrump/ubuntu-template:20.04 AS base

COPY --from=builder /lib/x86_64-linux-gnu/libboost_system.so.1.71.0 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libboost_program_options.so.1.71.0 /lib/x86_64-linux-gnu/
COPY --from=builder /usr/local /usr/local

RUN ldd /usr/local/bin/trojan

CMD ["trojan"]
