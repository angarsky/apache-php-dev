FROM tommylau/xdebug

COPY ext-xdebug.ini /usr/local/etc/php/conf.d/

# openssh installation
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
COPY sshd_config /etc/ssh/sshd_config

RUN adduser dev --disabled-password --gecos ""
RUN usermod -aG www-data dev

RUN mkdir /home/dev/.ssh
COPY authorized_keys /home/dev/.ssh/authorized_keys
RUN chmod 700 /home/dev/.ssh
RUN chmod 600 /home/dev/.ssh/authorized_keys
RUN chown -R dev:dev /home/dev/.ssh

EXPOSE 22

# supervisor installation
RUN apt-get -y install supervisor && \
  mkdir -p /var/log/supervisor && \
  mkdir -p /etc/supervisor/conf.d

COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
