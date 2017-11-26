FROM microsoft/aspnetcore-build

WORKDIR /source

COPY . .

RUN ["dotnet", "restore"]

CMD chmod +x ./initialize.sh && /bin/bash ./initialize.sh