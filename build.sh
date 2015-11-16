#!/bin/bash

PWD=$(pwd)

cd iptables_1.4.20

autoreconf -fi;
rm -Rf autom4te*.cache;

export PATH=/home/emil/arm-linux-androideabi/bin:$PATH

./configure --enable-static --disable-shared  --host=arm-linux-androideabi --build=x86_64-linux-gnu  CFLAGS='-fPIE' LDFLAGS='-fPIE -pie'  CPPFLAGS='-fPIE' libnetfilter_conntrack_CFLAGS='-fPIE' libnfnetlink_CFLAGS='-fPIE'

make -j4

cp ./iptables/xtables-multi ../iptables || ret=$?

if [ "$ret" != "" ] && [ "$ret" != "0" ]; then
  echo -e "\e[1;31mCopying iptables binary failed, non zero status returned - $ret\e[0m"
else
  echo -e "\e[1;32mCopied iptables binary successfully\e[0m"
fi

echo -e "\n\e[1;34mOutput: $PWD/iptables\e[0m\n"

exit $ret
