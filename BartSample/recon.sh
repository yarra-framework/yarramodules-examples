#/bin/bash

cd $1
shift

bart twixread -A "$1" tmp1
bart fft -i -u $(bart bitmask 0 1 2) tmp1 tmp2
bart rss $(bart bitmask 3) tmp2 tmp3
bart crop 0 256 tmp3 tmp4

shift
bart toimg tmp4 "$1/result.dcm"

