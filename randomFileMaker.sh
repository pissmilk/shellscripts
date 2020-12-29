#! /bin/bash
for x in {1..5}
do
       	var=$(cat /dev/urandom | tr -dc '_a-zA-Z0-9' | fold -w 32 | head -n 1)
       	dd if=/dev/urandom bs=1 count=1 of=$var
done
