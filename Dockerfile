FROM registry.redhat.io/ubi8/ubi:8.10-1184.1741795395  as builder

WORKDIR /build
ADD . /build/


RUN mkdir /tmp/cache
RUN CGO_ENABLED=0 GOCACHE=/tmp/cache go build  -mod=vendor -v -o /tmp/api-server .

FROM scratch

WORKDIR /app
COPY --from=builder /tmp/api-server /app/api-server

CMD [ "/app/api-server" ]
