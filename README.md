## EEA Eggrepo docker setup

Custom repository for python eggs

### Installation

1. Install [Docker](https://www.docker.com/).
2. Install [Docker Compose](https://docs.docker.com/compose/).

## Production 

### Deployment

* Within `Rancher Catalog > EEA` deploy:
  * EEA - Eggs Server Repository

### Production data migration

### Data migration

1. Start **rsync client** on host from where do you want to migrate eggrepo data (SOURCE HOST):

  ```
    $  docker run -it --rm --name=r-client -v eggrepo:/data eeacms/rsync sh
  ```

2. Start **rsync server** on host where do you want to migrate eggrepo data (DESTINATION HOST):

  ```
    $ docker run -it --rm --name=r-server -p 2222:22 -v eggrepo:/data \
                 -e SSH_AUTH_KEY="<SSH-KEY-FROM-R-CLIENT-ABOVE>" \
             eeacms/rsync server
  ```

3. Within **rsync client** container from step 1 run:

  ```
    $ rsync -e 'ssh -p 2222' -avz /data/ root@<DESTINATION HOST IP>:/data/
  ```
