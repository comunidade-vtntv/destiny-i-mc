FROM adoptopenjdk/openjdk8:alpine-jre

# Argumentos para corrigir permissões dos ficheiros (deve ter os mesmos valores do utilizador host que vai rodar o container)
ARG USER=destinyi GID=1001 UID=1000 GROUP=destinyi

# Argumentos de compilação do container e uso do easy-add para instalar o mc-monitor, suportando várias arquiteturas
ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

ARG EASY_ADD_VER=0.7.1

ADD https://github.com/itzg/easy-add/releases/download/${EASY_ADD_VER}/easy-add_${TARGETOS}_${TARGETARCH}${TARGETVARIANT} /usr/bin/easy-add
RUN chmod +x /usr/bin/easy-add && easy-add --var os=${TARGETOS} --var arch=${TARGETARCH}${TARGETVARIANT} \
 --var version=0.9.0 --var app=mc-monitor --file {{.app}} \
 --from https://github.com/itzg/{{.app}}/releases/download/{{.version}}/{{.app}}_{{.version}}_{{.os}}_{{.arch}}.tar.gz && rm /usr/bin/easy-add


# Directório Principal, importação de ficheiros importantes do servidor, preparação do container e importação de scripts para gestão deste
WORKDIR /destiny-i/server
COPY server-overrides/ .
COPY config-scripts/ /bin
COPY server-scripts/install_server /bin
COPY server-scripts/run_server /bin
COPY server-scripts/ .
RUN chmod +x /bin/prepare_container && /bin/prepare_container && rm /bin/prepare_container



# Mudar para um utilizador menos priveligiado, preparar o método de paragem do container e montagem de volumes
USER $USER
STOPSIGNAL SIGTERM
VOLUME [ "/destiny-i/server/world", "/destiny-i/server-config", "/destiny-i/server/logs", "/destiny-i/backups" ]

# Configurações/Especificações do container
EXPOSE 35000/tcp 35000/udp 35001/tcp 35002/tcp
ENV RAM="6G" ONLINE_MODE="false" MAX_PLAYERS=25 RCON_ENABLED="false" RCON_PASSWORD="destinyircon" DIFFICULTY="hard" GAMEMODE="survival" LEVEL_TYPE="default" BACKUPS_ENABLED="true" 

ENTRYPOINT [ "./run_server" ]
HEALTHCHECK --start-period=3m CMD ./health_server


