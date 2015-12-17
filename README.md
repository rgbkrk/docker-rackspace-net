# racknet

Query the host networking when working in a Docker environment on Rackspace

```
$ docker run --net=host --rm racknet/ip public
104.130.0.127
```

```
$ docker run --net=host --rm racknet/ip service
10.184.13.252
```

## Usage

```
racknet public [ipv4|ipv6]
racknet service [ipv4|ipv6]

Examples:
          $ racknet public
          104.130.0.127

          $ racknet public ipv6
          2001:4802:1234:5678:90ab:cdef:0123:4567

Examples when run with Docker:
          $ docker run --net=host racknet/ip public
          104.130.0.127
```
