## EEA Eggrepo docker setup

Docker "orchestration" for EEA Eggrepo, including images for **Apache** and **Pypi Mirror**.

You can find the base image for **Apache Server** [here](https://hub.docker.com/r/eeacms/apache/).

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

### Only for EEA developers
There are some files that you should include in data container and provide accessibility to them. Example below:

    libevent-2.0.21-stable.tar.gz -> http://example/pypi/libevent/libevent-2.0.21-stable.tar.gz
    wkhtmltopdf-0.12.1.tgz -> http://example/pypi/wkhtmltopdf/wkhtmltopdf-0.12.1.tgz
    
#### How to do it

    $ mkdir -p pypi_data/libevent
    $ mkdir -p pypi_data/wkhtmltopdf
    $ cp /path/to/libevent-2.0.21-stable.tar.gz pypi_data/libevent
    $ cp /path/to/eggs/wkhtmltopdf-0.12.1.tgz pypi_data/wkhtmltopdf

After creation of eggrepo-data folder execute:

    $ docker-compose up data
    $ docker run -it --rm --volumes-from eeadockereggrepo_pypimirror_data_1 -v \
      /path/to/pypi_data:/mnt debian /bin/bash -c "cp -R /mnt/* /var/local/pypi"    
