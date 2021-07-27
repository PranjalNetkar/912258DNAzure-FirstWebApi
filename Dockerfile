#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["HandsonCloud7/HandsonCloud7.csproj", "HandsonCloud7/"]
RUN dotnet restore "HandsonCloud7/HandsonCloud7.csproj"
COPY . .
WORKDIR "/src/HandsonCloud7"
RUN dotnet build "HandsonCloud7.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HandsonCloud7.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HandsonCloud7.dll"]


