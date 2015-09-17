FROM scratch
MAINTAINER Kyle Kelley <kyle.kelley@rackspace.com>
EXPOSE 8080
ADD racknet /racknet
ENTRYPOINT ["/racknet"]
