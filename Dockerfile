FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
RUN echo $(ls -a) 
WORKDIR /app


# Copy csproj and restore as distinct layers
COPY ./AmritDemoApp/*.csproj ./
RUN echo $(ls -a) 
RUN dotnet restore

# Copy everything else and build
COPY ./AmritDemoApp/ ./
RUN echo $(ls -a) 
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .
ENV ASPNETCORE_URLS=http://+:5000
ENV DOTNET_URLS=http://+:5000
ENTRYPOINT ["dotnet", "AmritDemoApp.dll"]
