FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env

WORKDIR /AmritDemoApp
COPY *.csproj ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /AmritDemoApp/out .
ENTRYPOINT ["dotnet", "aspnetcoreapp.dll"]
