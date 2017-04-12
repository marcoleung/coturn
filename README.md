Coturn for Docker
=================

A Docker container with the Coturn STUN and TURN server (https://code.google.com/p/coturn/)

Pull this image with `docker pull dreamnetwork/coturn`.

You can run a container from this image like this:

```
docker run -d --name=turnserver --restart="on-failure:10" --net=host -p 3478:3478 -p 3478:3478/udp dreamnetwork/coturn
```

This will use icanhazip (http://major.io/icanhazip-com-faq/) to determine your container's public IP address. If you don't wish to use icanhazip, or you wish to use an external IP address that doesn't match what icanhazip would see, you can specify it in the environment:

```
docker run -d -e EXTERNAL_IP=1.2.3.4 --name=turnserver --restart="on-failure:10" --net=host -p 3478:3478 -p 3478:3478/udp dreamnetwork/coturn
```

Environment Parameters
-----------------
* `SKIP_AUTO_IP` -- binds to any address, useful for IPv4 and IPv6 dual-stack when also running with --net=host
* `EXTERNAL_IP` -- optional manually-specified external IP address
* `PORT` -- listening port for STUN and TURN
* `LISTEN_ON_PUBLIC_IP` -- bind to the external IP
* `USE_IPV4` -- forces IPv4 when determining the external IP
* `MIN_PORT` -- Lower bound of the UDP port range for relay endpoints allocation. Default value is 49152, according to RFC 5766.
* `MAX_PORT` -- Upper bound of the UDP port range for relay endpoints allocation. Default value is 65534.
* `MONGO_HOST` -- User database connection host string for MongoDB
* `PROD` -- Default verbose mode. PROD will disable verbose mode 
