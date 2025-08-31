# .NET SDK (build aşaması)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

WORKDIR /app
COPY . .

RUN dotnet publish -c Release --property:PublishDir=/out

# .NET Runtime (çalıştırma aşaması)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app
COPY --from=build-env /out .

# Uygulamayı başlat
ENTRYPOINT ["dotnet", "aspnet-core-ci-cd.dll"]
