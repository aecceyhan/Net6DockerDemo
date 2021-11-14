FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source


# Copy csproj and restore as distinct layers
COPY /DockerDemo/DockerDemo.csproj ./ 
RUN dotnet restore

# copy everything else and build app
COPY . ./
WORKDIR /source
RUN dotnet publish -c release -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app/out
COPY --from=build /app ./
CMD ["dotnet", "DockerDemo.dll"]
