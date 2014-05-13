#!/bin/bash
pht=0
pid=`pidof i3lock`
while [ $pid ];
do
  h1=`date | awk {'print $5'} | cut -b 1-2`
  m1=`date | awk {'print $5'} | cut -b 4-5`
  h=`journalctl -xn | grep 'pam_unix(i3lock:auth): authentication failure' | awk {'print $3'} | tail -n 1 | cut -b 1-2`
  m=`journalctl -xn | grep 'pam_unix(i3lock:auth): authentication failure' | awk {'print $3'} | tail -n 1 | cut -b 4-5`
  let t=(h1*60)
  let tt=t+m1
  let p=h*60
  let pp=p+m
  if [ $tt = $pp ];then
    if [ $pht -eq 0 ];then 
      echo -e "$(fswebcam -r 640x480 -F 10 -s brightness=80% ~/.i3lock.png)"
      pht=1
    fi
  fi
  if [ $tt != $pp ];then
    pht=0
  fi
  pid=`pidof i3lock`
done
