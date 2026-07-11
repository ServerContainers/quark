FROM alpine AS builder

RUN apk --no-cache add git make gcc libc-dev \
 && git clone git://git.suckless.org/quark \
 && cd quark \
 && git log -1 | grep Date: > /version \
 && make \
 && cp quark /quark-bin


FROM alpine

COPY --from=builder /quark-bin /bin/quark
COPY --from=builder /version /version

RUN mkdir /data

EXPOSE 80

CMD quark -h 0.0.0.0 -p 80 -d /data
