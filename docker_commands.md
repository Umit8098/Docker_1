## Komutlar:
* https://docs.docker.com/get-started/docker_cheatsheet.pdf


```sh

    $ docker --version
    $ docker version

    $ docker info
    
    $ docker --help
    $ docker help
    $ docker build --help

    $ docker search <imagename>

```

```sh
    
    # Image build et:
    $ docker build .
    # Image build et ve image'a isim ver:
    $ docker build . --tag <imagename>
    $ docker build . -t <imagename>
    # Image build et ve image'a isim:sürüm ver:
    $ docker build . -t <imagename>:v2
    $ docker build . -t <imagename>:v2 --no-cache

    # Image'leri listele:
    $ docker images ls
    $ docker images
    # Image sil:
    $ docker rmi <imagename>
    $ docker rmi <imagename> -f
    # Image'leri sil (kullanılmayanlar):
    $ docker images prune
    # Image tag ekle/değiştir:
    $ docker tag <imagename> <newimagename>

    # Image'den Container aç:
    $ docker run <imagename>
    # Image'den Container aç ve container'a isim ver:
    $ docker run --name <containername> <imagename>

    # Container'leri listele:
    $ docker container ls
    $ docker ps
    # Container'leri listele (tümü):
    $ docker container ls -a
    $ docker ps -a
    # Container başlat/durdur:
    docker start|stop <containername>
    # Container sil:
    $ docker rm <containername>
    $ docker rm <containername> -f
    # Container'leri sil (kullanılmayanlar):
    $ docker images prune

    # Interaktif modda aç:
    $ docker run -it <imagename> sh
    # Interaktif moddan çık:
    $ exit

```


```sh

    $ docker --version # Check version
    $ docker version # Check version with details 
    $ docker info # Check info
    $ docker help # Run help and see all commands
    $ docker search python # Run search commands
    $ docker <command> --help # Run help for any command.
    $ docker system prune -a # Stop and delete passive containers/images/caches.

    # ! It can write image_id instead of image_name.
    # ! It can write container_id instead of container_name.

    # Build Files to Image:
    $ docker build . # Create images from dockerfile, no-name
    $ docker rmi ab4 # image delete image_id
    $ docker build --tag <image_name> <folder_name> # Create images from dockerfile.
    $ docker build -t <image_name> # Create images from dockerfile.
    $ docker build -t <image_name>:<TAG> # Create images from dockerfile.
    $ docker build -t <image_name> <folder_name> # Create images from dockerfile.
    $ docker build . -t <image_name> --no-cache # cache kullanma
    $ docker build -t <user_name>/<image_name> .
    
    # Run Image to Container: (allways, image_name must be on the end):
    $ docker run -d -p <ext_port_number>:<int_port_number> <image_name> # run with external/internal port
    $ docker run -it <image_name> <terminal(sh)> # run docker with interctive mode, default terminal bash
    $ docker run -d --name <container_name> <image_name> # run and set container name
    $ docker run -d -p <ext_port_number>:<int_port_number> --name <container_name> <image_name>

    # IMAGES:
    $ docker images # List local images.
    $ docker image ls # List local images.
    $ docker rmi <image_name> # Delete image.

    # CONTAINERS:
    $ docker container ls # List local container.
    $ docker ps # List active containers.
    $ docker ps -a # docker ps --all # List all containers.
    $ docker start|stop <container_name> # Start/Stop container.
    $ docker rm <container_name> # Delete stopped container.
    $ docker container prune # delete all stopped container

    # DOCKERHUB:
    $ docker login # Login auto (get user-info from docker-desktop)
    $ docker login -u <user_name> # Login manual
    $ docker tag <image_name> <user_name>/<image_name>[:tag] # Connect repo and set tag
    $ docker push <user_name>/<image_name>[:tag] # PUSH
    $ docker pull <user_name>/<image_name>[:tag] # PULL
    $ docker search <image_name> # Search in DockerHub

```