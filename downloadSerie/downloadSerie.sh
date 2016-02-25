#!/bin/bash
#Script downloads from DR
echo $# arguments 
if (( $# != 4 )); then
    echo "Usage: $0 destination url from to"
    exit 1
fi

current=`pwd`
destination="$1"
url="$2"
from="$3"
to="$4"

cd $destination
youtube-dl $2

for (( i=$from; i<=$to; i++ ))
do
  echo "downloading episode $i" 
  youtube-dl $url-$i
done
cd $current
