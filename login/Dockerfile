FROM ubuntu:16.04
MAINTAINER Ali Batuhan ÜNDAR <batuhan.undar01@gmail.com>

RUN apt-get update && apt-get -y install \ 
				libnss-ldap \
				libpam-ldap \
				openssh-server \
				openssh-client \
				ldap-utils \
				curl \
				nscd

RUN echo "session required        pam_mkhomedir.so skel=/etc/skel umask=077" >> /etc/pam.d/common-session

ADD client-files /client

#RUN sed -i "s/{LDAP_BASE}/dc=example,dc=org/" /client/ldap.conf
#RUN sed -i "s/{LDAP_URI}/ldap:\/\/openldap:389 ldaps:\/\/openldap:636/" /client/ldap.conf

#RUN sed -i "s/{LDAP_ROOT_DN}/dc=admin,dc=example,dc=org/" /client/ldap-etc.conf
#RUN sed -i "s/{LDAP_URI}/ldap:\/\/openldap:389/" /client/ldap-etc.conf
#RUN sed -i "s/{LDAP_BASE}/dc=example,dc=org/" /client/ldap-etc.conf

RUN mv /client/entrypoint.sh /usr/local/bin/
RUN cp /client/ldap-etc.conf /etc/ldap.conf
RUN cp /client/ldap.conf /etc/ldap/
RUN cp /client/nsswitch.conf /etc/
RUN cp /client/ldap.secret /etc/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 22
