FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

# Install Microsoft repo + mssql-tools18 (includes sqlcmd)
RUN apt-get update \
 && apt-get install -y curl apt-transport-https gnupg unixodbc-dev \
 && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-prod.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install -y mssql-tools18 \
 && ln -s /opt/mssql-tools18/bin/sqlcmd /usr/local/bin/sqlcmd \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY ./init/init.sh /usr/src/app/init.sh
COPY ./init/restore.sql /usr/src/app/restore.sql
RUN chmod +x /usr/src/app/init.sh

USER mssql

CMD ["/bin/bash", "-c", "/opt/mssql/bin/sqlservr & /usr/src/app/init.sh && wait"]
