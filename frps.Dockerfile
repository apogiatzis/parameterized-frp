FROM golang:1.20 AS building

COPY ./frp /building
WORKDIR /building

RUN make frps

FROM alpine:3

COPY --from=building /building/bin/frps /usr/bin/frps

COPY frps.ini /conf/frps.ini

ENTRYPOINT ["/usr/bin/frps","-c","/conf/frps.ini"]
