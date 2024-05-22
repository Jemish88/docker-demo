Getting Started with Docker
=> This project is designed for running a Spring Boot application image locally using Docker.
Prerequisites:
1. Install Docker Desktop from here: https://www.docker.com/products/docker-desktop
2. Enable the following Windows features:
   - Virtual Machine Platform
   - Windows Subsystem for Linux

Usage:
1. Build and install your Spring Boot project.

   Run the following commands:
   - docker build -t my-application .
   - docker run -p 8080:8080 my-application

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
