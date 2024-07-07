FROM openresty/openresty:jammy

WORKDIR /app

RUN apt update
RUN apt install -y luarocks
RUN apt install -y lua5.1
RUN apt install -y sqlite3
RUN apt install -y libssl-dev
RUN apt install -y libsqlite3-dev

RUN luarocks install luasec
RUN luarocks install lapis 
RUN luarocks install etlua 
RUN luarocks install lsqlite3
RUN luarocks install tableshape

COPY . .

RUN lapis migrate production

RUN chmod a+rw /app /app/*

EXPOSE 8080

CMD ["lapis", "server", "production"]


