Getting Started with Docker
=> This project is designed for running a Spring Boot application image locally using Docker.
Prerequisites:
1. Install Docker Desktop from here: https://www.docker.com/products/docker-desktop
2. Enable the following Windows features:
   - Virtual Machine Platform
   - Windows Subsystem for Linux

Usage:
1. Build and install your Spring Boot project.
2. Make Dockerfile using below commands:
   FROM openjdk:21
   VOLUME /tmp
   EXPOSE 8080
   ARG JAR_FILE=target/spring-boot-docker.jar
   ADD ${JAR_FILE} app.jar
   ENTRYPOINT ["java","-jar","/app.jar"]

Explanation of the Dockerfile:
- `FROM openjdk:11`: Specifies the base image with OpenJDK 21 (Java Development Kit version 21).
- `VOLUME /tmp`: Creates a mount point at `/tmp` for holding external volumes.
- `EXPOSE 8080`: Informs Docker that the container listens on port 8080.
- `ARG JAR_FILE=target/spring-boot-docker.jar`: Defines a build-time variable `JAR_FILE` with a default value pointing to the JAR file.
- `ADD ${JAR_FILE} app.jar`: Copies the JAR file into the Docker image and renames it to `app.jar`.
- `ENTRYPOINT ["java","-jar","/app.jar"]`: Sets the command to run the JAR file using the Java runtime when the container starts.
   
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

Notes:
- Ensure Docker Desktop is running before executing Docker commands.
- Replace {container-id or name} and {image-id or name} with the actual container or image IDs/names as needed.
