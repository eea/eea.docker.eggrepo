FROM eeacms/apache:2.2

MAINTAINER "Vitalie Maldur" <vitalie.maldur@eaudeweb.ro>

#install dependencies
RUN yum -y makecache; yum clean all
RUN yum -y install gcc httpd-devel git python-devel flex tar python-setuptools mod_authz_ldap; yum clean all

RUN git clone https://github.com/grisha/mod_python.git && \
    cd mod_python/ && ./configure --with-python=/usr/bin/python  && make && make install

RUN git clone https://github.com/eea/collective.eggproxy.git && \
    cd collective.eggproxy && python setup.py install

ADD eggproxy.conf /etc/eggproxy.conf

# clean up
RUN rm -rf mod_python/ && rm -rf collective.eggproxy

# configuration
ADD vh.conf /etc/httpd/conf.d/vh-eggrepo.conf
ADD python_module.conf /etc/httpd/conf.d/pyrhon_module.conf
