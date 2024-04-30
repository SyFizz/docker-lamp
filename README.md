# Dockerized LAMP stack for PHP apps
This Docker image was created for the need to dockerize Laravel applications.
It was build over the official PHP image, and customized to my needs.
## Stack usage
To use the stack with the database server and the webserver, you need to use the `docker-compose.yml` file.
This file was written to be used in a Portainer instance, and must be customized to be used as is.

First, you need to replace all the variables `{{like_this}}`.
Then you need to change the volumes to be mounted where you need. Remember that the syntax for Docker volumes are `/path/on/host:/path/in/container`.
In this case, the path inside the container will always be `/app`, as it is the root used for the webserver.

## Building the image

In the /image folder, you have the Dockerfile and all the ressources needed to edit and build the image.
To do so, modify the configurations or the Dockerfile to suit your needs, and then run
```bash
docker build -t yourcompany/yourname:tag 
```
