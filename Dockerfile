FROM debian:jessie

# Add local copy of GPG key so we know it hasn't changed
ADD GPG-KEY-td-agent /tmp/GPG-KEY-td-agent
RUN apt-key add /tmp/GPG-KEY-td-agent

RUN echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update
RUN apt-get install -y --force-yes adduser td-agent

ADD td-agent.conf /etc/td-agent/td-agent.conf

# install fluentd plugins
RUN /opt/td-agent/embedded/bin/fluent-gem install --no-ri --no-rdoc \
    fastly_fluent

# Recommended for better memory management
ENV LD_PRELOAD /opt/td-agent/embedded/lib/libjemalloc.so

EXPOSE 514
USER td-agent

# --use-v1-config allows use of "#{ENV['SOMENAME']}" syntax
CMD ["/usr/sbin/td-agent", "--use-v1-config"]
