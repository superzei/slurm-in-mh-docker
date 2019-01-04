FROM ubuntu:16.04
MAINTAINER Ali Batuhan ÜNDAR <batuhan.undar01@gmail.com>

RUN apt-get update && apt-get -y install \ 
				libnss-ldap \
				libpam-ldap \
				ldap-utils \
				nscd

RUN echo "session required        pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session

RUN service nscd restart

ADD client-files /client

RUN sed -i "s/{LDAP_BASE}/dc=example,dc=org/" /client/ldap.conf
RUN sed -i "s/{LDAP_URI}/ldap:\/\/openldap:386 ldaps:\/\/openldap:636/" /client/ldap.conf

RUN sed -i "s/{LDAP_ROOT_DN}/dc=admin,dc=example,dc=org/" /client/ldap-etc.conf
RUN sed -i "s/{LDAP_URI}/ldap:\/\/openldap/" /client/ldap-etc.conf
RUN sed -i "s/{LDAP_BASE}/dc=example,dc=org/" /client/ldap-etc.conf

RUN cp /client/ldap-etc.conf /etc/ldap.conf
RUN cp /client/ldap.conf /etc/ldap/
RUN cp /client/nsswitch.conf /etc/



ENTRYPOINT ["tail", "-f", "/dev/null"]
