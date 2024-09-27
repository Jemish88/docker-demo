# Getting Started with Docker

This project demonstrates how to build and run a Spring Boot application using Docker with a multi-stage Dockerfile. The Dockerfile includes a build stage with Maven and OpenJDK and a second stage for creating a slim runtime image.

## Prerequisites

1. **Install Docker Desktop**: You can download and install Docker Desktop from [here](https://www.docker.com/products/docker-desktop).
2. **Enable the following Windows features** (if using Windows):
   - Virtual Machine Platform
   - Windows Subsystem for Linux (WSL)

## Dockerfile Overview

This Dockerfile uses a multi-stage build:
1. **Stage 1**: Builds the Spring Boot application using Maven and OpenJDK.
2. **Stage 2**: Creates a smaller runtime image with only the necessary files to run the application.

### Dockerfile

```dockerfile
# Stage 1: Build stage with Maven and OpenJDK
FROM openjdk:21-slim AS build

# Install Maven in the build stage
RUN apt-get update && apt-get install -y maven

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .

# Download dependencies without running the whole build (offline mode)
RUN --mount=type=cache,target=/root/.m2 mvn dependency:go-offline

# Copy the project source
COPY src ./src

# Build the Spring Boot application
RUN --mount=type=cache,target=/root/.m2 mvn clean package -DskipTests

# Stage 2: Create a smaller runtime image for the Spring Boot app
FROM openjdk:21-slim

# Set the working directory for the runtime image
WORKDIR /app

# Copy only the built JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]


## Explanation of the Dockerfile

### Stage 1: Build Stage

- **`FROM openjdk:21-slim AS build`**: 
  - Starts with a lightweight OpenJDK image.

- **`RUN apt-get update && apt-get install -y maven`**: 
  - Installs Maven for building the application.

- **`WORKDIR /app`**: 
  - Sets the working directory to `/app`.

- **`COPY pom.xml .`**: 
  - Copies the `pom.xml` file to the container.

- **`RUN mvn dependency:go-offline`**: 
  - Downloads project dependencies in offline mode.

- **`COPY src ./src`**: 
  - Copies the source code of the project.

- **`RUN mvn clean package -DskipTests`**: 
  - Builds the project and creates the JAR file, skipping tests.

### Stage 2: Runtime Stage

- **`FROM openjdk:21-slim`**: 
  - Uses a slim OpenJDK image to keep the final image small.

- **`WORKDIR /app`**: 
  - Sets the working directory to `/app`.

- **`COPY --from=build /app/target/*.jar app.jar`**: 
  - Copies the built JAR from the build stage.

- **`EXPOSE 8080`**: 
  - Exposes port 8080 for the Spring Boot application.

- **`ENTRYPOINT ["java", "-jar", "app.jar"]`**: 
  - Runs the JAR file using the Java runtime.
 
Run the following commands:
   - docker build -t my-application .
   - docker run -p 8080:8080 my-application

"my-application" was image name we can name it as we wanted

Managing Docker Containers and Images:
1. Check running containers: docker container ls
2. Check existing images: docker images
3. Remove a container: docker rm {container-id or name}
4. Remove all containers: docker rm $(docker ps -qa)
5. Remove an image: docker rmi {image-id or name}
6. Remove all images: docker rmi -f $(docker images -aq)
7. Clean up unused Docker resources: docker system prune -a --volumes
8. Stop container: docker stop {container-id or name}

Notes:
- Ensure Docker Desktop is running before executing Docker commands.
- Replace {container-id or name} and {image-id or name} with the actual container or image IDs/names as needed.
