#!/bin/sh

(
while true; do
	freshclam
	sleep 8h
done
) &
BACKGROUND_TASKS="$!"

# http://sanesecurity.com/usage/signatures/
(
while true; do
	sleep 2m
	SANE_MIRRORS="$(nslookup rsync.sanesecurity.net 2>/dev/null | grep Address | cut -d' ' -f 3)"
	for sane_mirror in ${SANE_MIRRORS}; do
		rsync -ctuzvr --no-motd --chmod=Du=rwx,Dgo=rx,Fu=rw,Fog=r --timeout=5 \
			rsync://${sane_mirror}/sanesecurity/ \
			--include 'blurl.ndb' \
			--include 'foxhole_generic.cdb' \
			--include 'foxhole_filename.cdb' \
			--include 'junk.ndb' \
			--include 'jurlbl.ndb' \
			--include 'hackingteam.hsb' \
			--include 'malwarehash.hsb' \
			--include 'phishtank.ndb' \
			--include 'phish.ndb' \
			--include 'spamattach.hdb' \
			--include 'spamimg.hdb' \
			--include 'scam.ndb' \
			--include 'rogue.hdb' \
			--include 'sanesecurity.ftm' \
			--include 'sigwhitelist.ign2' \
			--exclude='*' /var/lib/clamav/
		if [ $? -eq 0 ]; then
			echo RELOAD | nc localhost 3310
			break
		fi
	done
	sleep 30h
done
) &
BACKGROUND_TASKS="${BACKGROUND_TASKS} $!"

# creating a minimal database so daemon can start
echo "48c4533230e1ae1c118c741c0db19dfb:17387:test.exe" > /var/lib/clamav/firststart.hdb
nice -n10 clamd &
BACKGROUND_TASKS="${BACKGROUND_TASKS} $!"

(
while [ ! "$(echo PING | nc localhost 3310)" = "PONG" ]; do sleep 10; done
rm firststart.hdb
) &

while true; do
	for bg_task in ${BACKGROUND_TASKS}; do
		if ! kill -0 ${bg_task} 1>&2; then
			echo "Worker ${bg_task} died, stopping container waiting for respawn..."
			kill -TERM 1
		fi
		sleep 10
	done
done
