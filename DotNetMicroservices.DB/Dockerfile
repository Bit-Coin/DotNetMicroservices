FROM microsoft/aspnetcore-build:2.0

WORKDIR /source

COPY . .

RUN ["dotnet", "restore"]

CMD chmod +x ./initialize.sh && /bin/bash ./initialize.sh