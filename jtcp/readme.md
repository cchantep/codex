# Java TCP

Using TCP networking from Java.

## Build

```jtcp# javac *.java```

## Run server

```jtcp# java -classpath . TCPServerMain 9999```

Server will listen to TCP connection on port `9999`. 
This can be changed.

## Run client

```jtcp# java -classpath . TCPClientMain localhost 9999 nickname```

* `localhost`: Hostname/IP address to connect to the server.
* `9999`: Port on which the server listens to (there on host `localhost`).
* `nickname`: Client nickname
