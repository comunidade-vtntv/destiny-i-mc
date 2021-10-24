# Destiny I - Servidor Minecraft

> Seja bem-vindo ao repositório oficial do servidor Destiny I, que contém tudo o que é necessário para configuração e execução deste no seu computador, VPS, ...

# Execução do servidor
## Usando Docker (Recomendado)
### Iniciar servidor
> docker run -d --name destiny_i_mc -p 35000:35000/tcp ghcr.io/comunidade-vtntv/destiny-i-mc:l.1
### Iniciar servidor com comunicação por voz do Mekanism (a porta [35002/tcp] só funciona se for mapeada para o host com o mesmo número)
> docker run -d --name destiny_i_mc -p 35000:35000/tcp -p 35002:35002/tcp ghcr.io/comunidade-vtntv/destiny-i-mc:1.1
### Iniciar servidor com RCON ativo para gestão remota deste
> docker run -d --name destiny_i_mc -e RCON_ENABLED=true -p 35000:35000/tcp -p 35001:35001/tcp ghcr.io/comunidade-vtntv/destiny-i-mc:1.1

# Encontre-nos:
> DIscord VTNTV: https://discord.gg/ARCubjY
