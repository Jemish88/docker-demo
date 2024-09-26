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
