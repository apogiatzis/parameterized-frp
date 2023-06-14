FROM golang:1.20 AS building

COPY ./frp /building
WORKDIR /building

RUN make frpc

FROM alpine:3

COPY --from=building /building/bin/frpc /usr/bin/frpc

COPY frpc.ini /conf/frpc.ini

ENTRYPOINT ["/usr/bin/frpc","-c", "/conf/frpc.ini"]
