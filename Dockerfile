# Use a base image with Lua and OpenResty
FROM openresty/openresty:alpine

# Set the working directory inside the container
WORKDIR /app

# Install LuaRocks and other necessary packages
RUN apk add --no-cache \
lua5.1-dev \
openssl-dev \
gcc \ 
musl-dev \
make \ 
unzip \ 
openssl \ 
curl \ 
wget \ 
lf \
sqlite-dev \
sqlite 

# Download and install LuaRocks
RUN wget https://luarocks.org/releases/luarocks-3.7.0.tar.gz && \
    tar zxpf luarocks-3.7.0.tar.gz && \
    cd luarocks-3.7.0 && \
    ./configure && \
    make && \
    make install

# Install dependencies (if any extra)
RUN luarocks install lapis 
RUN luarocks install etlua 
RUN luarocks install lsqlite3

# Copy your Lapis web app files into the container
COPY . .

# Expose the port your Lapis app runs on
EXPOSE 8080

RUN lapis migrate

# Command to start your Lapis app
CMD ["lapis", "server", "production"]

