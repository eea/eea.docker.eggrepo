## EEA Eggrepo docker setup

**NOTE: DEPRECATED - use eea.docker.cluereleasemanager instead**

Docker "orchestration" for EEA Eggrepo, including images for **Apache** and **Pypi Mirror**.

### Installation
1. Install [Docker](https://www.docker.com/).
2. Install [Docker Compose](https://docs.docker.com/compose/).

### Usage

    $ git clone https://github.com/eea/eea.docker.eggrepo
    $ cd eea.docker.eggrepo
    $ docker-compose up

### Restore application data
Create a folder with SQLite database and a folder with all eggs:

    $ mkdir -p eggrepo-data/files
    $ cp /path/to/cluerelmgr.db eggrepo-data
    $ cp /path/to/eggs/folder eggrepo-data/files

Exemple of the result:

    $ ls eggrepo-data
    cluerelmgr.db  files

    $ ls eggrepo-data/files
    b  c  e  h  i  j  l  m  p  s  t  v  z

    $ ls eggrepo-data/files/c
    cairosvg                    collective.quickupload       collective.sendaspdf      colorama
    collective.googleanalytics  collective.recipe.distutils  collective.traceview      cornerstone.feed.core
    collective.jstree           collective.recipe.template   collective.xmltestreport  cornerstone.feed.zope

After creation of eggrepo-data folder execute:

    $ docker-compose up data
    $ docker run -it --rm --volumes-from eeadockereggrepo_eggrepo_data_1 -v \
      /path/to/eggrepo-data:/mnt debian /bin/bash -c "cp -R /mnt/* /var/local/eggrepo"

### Data migration

You can access production data on [EEA Eggrepo](http://eggrepo.eea.europa.eu). **cluerelmgr.db** is located at:

    /var/local/eggrepo/cluerelmgr.db

**Eggs folder** is located at:

    /var/local/eggrepo/files

Thus:

1. Start **rsync client** on host where do you want to migrate eggrepo data (DESTINATION HOST):

  ```
    $  docker run -it --rm --name=r-client --volumes-from=eeadockereggrepo_data_1 eeacms/rsync sh
  ```

2. Start **rsync server** on host from where do you want to migrate eggrepo data (SOURCE HOST):

  ```
    $ docker run -it --rm --name=r-server -p 2222:22 --volumes-from=eeadockereggrepo_data_1 \
                 -e SSH_AUTH_KEY="<SSH-KEY-FROM-R-CLIENT-ABOVE>" \
             eeacms/rsync server
  ```

3. Within **rsync client** container from step 1 run:

  ```
    $ rsync -e 'ssh -p 2222' -avz root@<SOURCE HOST IP>:/var/local/eggrepo/ /var/local/eggrepo/
  ```
