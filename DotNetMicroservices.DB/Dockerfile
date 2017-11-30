FROM microsoft/dotnet:sdk AS builder
WORKDIR /source

COPY *.csproj .

RUN dotnet restore

COPY . .

RUN dotnet publish -c Release -o /app/

FROM microsoft/dotnet:2.0-runtime 
WORKDIR /app

COPY --from=builder /app .

ENTRYPOINT ["dotnet", "DotNetMicroservices.DB.dll"]
