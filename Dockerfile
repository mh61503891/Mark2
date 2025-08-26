FROM mcr.microsoft.com/dotnet/sdk:9.0
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y python3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN dotnet workload install wasm-tools
WORKDIR /src
COPY . .
RUN dotnet publish Mark2.csproj -p:GHPages=true -p:GHPagesBase=/ -c:Release -o:publish
ENTRYPOINT ["/usr/bin/python3", "-m", "http.server", "-b", "0.0.0.0", "-d", "publish/wwwroot", "5296"]
