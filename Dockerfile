FROM centos:centos6
MAINTAINER OGATA Takahiro <marty_taka@hotmail.com>
ENV envDomainName ml.kiwi.useiis7.net
RUN yum -y install postfix perl tar expect
RUN groupadd -g 1001 fml && useradd -u 1001 -g fml fml
RUN mkdir /usr/local/fml /var/spool/ml && chown fml.fml /usr/local/fml /var/spool/ml
USER fml
RUN cd /tmp && curl -sS ftp://ftp.fml.org/pub/fml/stable/fml-4.0-stable-20040215.tar.gz | tar xfz -
RUN cd /tmp/fml-4.0-stable-20040215 && \
expect -c "\
spawn perl makefml install;\
expect \"Personal, Group, Fmlserv\" { send \"\r\" };\
expect \"DOMAIN NAME\" { send \"$envDomainName\r\" };\
expect \"FQDN\" { send \"\r\" };\
expect \"EXEC FILES DIRECTORY\" { send \"\r\" };\
expect \"TOP LEVEL ML DIRECTORY\" { send \"\r\" };\
expect \"Language\" { send \"Japanese\r\" };\
expect \"TimeZone\" { send \"+0900\r\" };\
expect \"Install the Fml system\" { send \"y\r\" };\
expect eof;\
"
USER root
RUN cp -a /etc/postfix/main.cf /etc/postfix/main.cf-000 && \
postconf -e "mydomain = $envDomainName" && \
postconf -e 'allow_mail_to_commands = alias, forward, include' && \
postconf -e 'inet_protocols = ipv4' && \
postconf -e 'inet_interfaces = all'
CMD service postfix start && bash