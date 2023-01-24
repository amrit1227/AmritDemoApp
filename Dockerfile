FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env

WORKDIR /AmritDemoApp
COPY *.csproj ./
WORKDIR /
RUN dotnet restore
WORKDIR /AmritDemoApp
COPY . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /AmritDemoApp
COPY --from=build-env /AmritDemoApp/out .
ENTRYPOINT ["dotnet", "aspnetcoreapp.dll"]
