# clamd

An antivirus container image, based on alpine, running the clamav daemon for use
via TCP port, i.e. in mail servers.

## Software stack

- clamd and freshclam are written in C.
- rsync is used for signature updates.
- busybox /bin/sh shell is used for service checks and update scheduling.

## Environment variables

- `TZ`: timezone used for logging, defaults to UTC

## Persistent volumes

- `/var/lib/clamav`: signature databases - owner 100, group 102, mode 0755

## Network ports

- `3310/tcp`

## Usage

```shell
make run
```

## Stop

```shell
make clean
```

## Build

```shell
make build
```

## Build & run

```shell
make
```

## Debug image contents

```shell
make debug
```
