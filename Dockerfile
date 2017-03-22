FROM harbor.dahuatech.com/chenmiao/debian:8.6

ENTRYPOINT ["/bin/sh","-c","/etc/rc.local;/bin/bash"]

CMD ["/bin/bash"]

COPY gitlab-*.deb /tmp

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
  apt-get update -y; \
  apt-get install curl openssh-server ca-certificates -y; \
  echo 'postfix postfix/mailname string your.hostname.com' | debconf-set-selections; \
  echo 'postfix postfix/main_mailer_type string "Internet Site"' | debconf-set-selections; \
  apt-get install postfix -y; \
  cd /tmp && dpkg -i gitlab-*.deb; \
  rm -rf /tmp/* && apt-get clean;

VOLUME ["/var/opt/gitlab/git-data"]


