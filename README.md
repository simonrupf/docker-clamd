# clamd

An antivirus container image, based on alpine, running the clamav daemon for use
via TCP port, i.e. in mail servers.

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
