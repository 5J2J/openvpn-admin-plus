FROM 5J2J/go-beego-bee-git
WORKDIR /go/src/github.com/5J2J

# Uncomment for a multi-arch buildx of the main branch
RUN git clone https://github.com/5J2J/openvpn-admin-plus
# Uncomment for a multi-arch buildx of the develop branch
# RUN git clone -b develop --single-branch https://github.com/5J2J/openvpn-admin-plus
WORKDIR /go/src/github.com/5J2J/openvpn-admin-plus
RUN go mod tidy && \
    bee pack -exr='^vendor|^data.db|^build|^README.md|^docs'

FROM debian:bullseye
WORKDIR /opt
EXPOSE 8080

RUN apt-get update && apt-get install -y easy-rsa && \
    chmod 755 /usr/share/easy-rsa/*
COPY --from=0  /go/src/github.com/5J2J/openvpn-admin-plus/build/assets/start.sh /opt/start.sh
COPY --from=0  /go/src/github.com/5J2J/openvpn-admin-plus/build/assets/generate_ca_and_server_certs.sh /opt/scripts/generate_ca_and_server_certs.sh
COPY --from=0  /go/src/github.com/5J2J/openvpn-admin-plus/build/assets/vars.template /opt/scripts/

COPY --from=0 /go/src/github.com/5J2J/openvpn-admin-plus/openvpn-admin-plus.tar.gz /opt/openvpn-gui-tap/
RUN tar -zxf /opt/openvpn-gui-tap/openvpn-admin-plus.tar.gz --directory /opt/openvpn-gui-tap/
RUN rm -f /opt/openvpn-gui-tap/db/data.db /opt/openvpn-gui-tap/openvpn-admin-plus.tar.gz
COPY --from=0 /go/src/github.com/5J2J/openvpn-admin-plus/build/assets/app.conf /opt/openvpn-gui-tap/conf/app.conf

CMD /opt/start.sh
