FROM httpd:2.4
MAINTAINER "Alin Voinea" <alin.voinea@eaudeweb.ro>

RUN apt-get update \
    && apt-get install -y --no-install-recommends libaprutil1-ldap \
    && rm -r /var/lib/apt/lists/*

RUN echo "Include conf/extra/virtual.conf" >> /usr/local/apache2/conf/httpd.conf

RUN sed -i 's|#LoadModule authnz_ldap_module|LoadModule authnz_ldap_module|' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's|#LoadModule ldap_module|LoadModule ldap_module|' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's|#LoadModule rewrite_module|LoadModule rewrite_module|' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's|#LoadModule proxy_module|LoadModule proxy_module|' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's|#LoadModule proxy_http_module|LoadModule proxy_http_module|' /usr/local/apache2/conf/httpd.conf

ADD vh.conf /usr/local/apache2/conf/extra/virtual.conf
