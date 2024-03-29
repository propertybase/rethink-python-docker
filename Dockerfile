FROM debian:jessie

MAINTAINER Christian Schultheiss <christian@propertybase.com>

# Add the RethinkDB repository and public key
# "RethinkDB Packaging <packaging@rethinkdb.com>" http://download.rethinkdb.com/apt/pubkey.gpg

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 1614552E5765227AEC39EFCFA7E00EF33A8F2399
RUN echo "deb http://download.rethinkdb.com/apt jessie main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.0.0+1~0jessie

RUN apt-get update \
  && apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION \
  && apt-get install -y python-pip \
  && pip install rethinkdb \
  && rm -rf /var/lib/apt/lists/* \

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

# process cluster webui
EXPOSE 28015 29015 8080
