FROM microsoft/aspnetcore-build:2.0 AS builder

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN apt-get update && apt-get install --no-install-recommends -y google-chrome-stable

WORKDIR /source

COPY . .

# restore nuget packages and install npm dependencies
RUN dotnet build

RUN cd ClientApp && $(npm bin)/ng test --config karma.conf.prod.js && cd ..

RUN dotnet publish -c Release -o /app/

FROM microsoft/aspnetcore:2.0

# install node.js for SSR
RUN apt-get update && apt-get install -my gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["dotnet", "DotNetMicroservices.SPA.dll"]