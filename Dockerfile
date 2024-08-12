FROM openresty/openresty:jammy

WORKDIR /app

ARG DATABASE_URL

RUN apt update
RUN apt install -y sqlite3 
RUN apt install -y libssl-dev 
RUN apt install -y libsqlite3-dev

RUN luarocks install luasec
RUN luarocks install bcrypt
RUN luarocks install lapis 
RUN luarocks install etlua 
RUN luarocks install lsqlite3
RUN luarocks install tableshape

COPY . .

RUN mkdir /data

RUN lapis migrate production --trace

EXPOSE 8080

CMD ["lapis", "server", "production"]
