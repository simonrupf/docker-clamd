# clamd change log

## 0.4.5
update to Alpine 3.20 / clamd 1.2.2

## 0.4.4
update to clamd 1.2.2

## 0.4.3
update to Alpine 3.19 / clamd 1.2.1

## 0.4.2
update to clamd 1.1.2

## 0.4.1
update to Alpine 3.18 / clamd 1.1.0

## 0.4.0
removed clamdscan & openssl, which are not used by the daemon

## 0.3.0
disable ConcurrentDatabaseReload, conserving memory during updates, restoring
pre-0.103.0 behavior, see https://blog.clamav.net/2020/09/clamav-01030-released.html

## 0.2.9
update to Alpine 3.17 / clamd 0.105.1

## 0.2.8
update to Alpine 3.16 / clamd 0.104.3

## 0.2.7
update to Alpine 3.15.3 / clamd 0.104.2

## 0.2.6
update to Alpine 3.15 / clamd 0.104.1

## 0.2.5
update to Alpine 3.14 / clamd 0.103.2

## 0.2.4
update to Alpine 3.13 / clamd 0.103.0

## 0.2.3
update to Alpine 3.12 / clamd 0.102.4

## 0.2.2
update to openssl 1.1.1g / clamd 0.102.1

## 0.2.1
update to Alpine 3.11 / clamd 0.102

## 0.2.0
add timezone support for logging, improve documentation

## 0.1.1
moving first start database creation into startup script

## 0.1.0
initial packaging, based on mailu alpine image with mailcow shell task manager
