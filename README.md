# clamd

An antivirus container image, based on alpine, running the clamav daemon for use
via TCP port, i.e. in mail servers.

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
