Getting Started with Docker
    Prerequisites
        Install Docker Desktop from here.
        Enable the following Windows features:
        Virtual Machine Platform
        Windows Subsystem for Linux
Usage
    Build and install your Spring Boot project.

Run your application in Docker using:
    docker build -t my-application .
    docker run -p 8080:8080 my-application
  
Managing Docker Containers and Images
    Check running containers: docker container ls
    Check existing images: docker images
    Remove a container: docker rm {container-id or name}
    Remove all containers: docker rm $(docker ps -qa)
    Remove an image: docker rmi {image-id or name}
    Remove all images: docker rmi -f $(docker images -aq)
    Clean up unused Docker resources: docker system prune -a --volumes
