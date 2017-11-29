FROM microsoft/aspnetcore-build

COPY . /app

WORKDIR /app

RUN ["dotnet", "restore"]

RUN ["dotnet", "build"]

CMD chmod +x ./initialize.sh && /bin/bash ./initialize.sh