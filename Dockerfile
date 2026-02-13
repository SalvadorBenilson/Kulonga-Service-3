FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY ["service3/service3.csproj", "service3/"]
RUN dotnet restore "service3/service3.csproj"

COPY . .
WORKDIR "/src/service3"
RUN dotnet build "service3.csproj" -c Release -o /app/build
RUN dotnet publish "service3.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "service3.dll"]
