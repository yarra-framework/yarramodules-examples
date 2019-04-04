#/bin/bash
set -euo pipefail

if [ ! $(which bart) ]; then
    echo "bart not found in PATH. Check to see if it is installed correctly."
    exit 1
fi

if [ "$#" -ne 3 ]; then
    echo "Invalid number of parameters"
    echo "Required: <infile> <outdir> <tmpdir>"
    exit 1
fi

infile=$1
outdir=$2
tmpdir=$3

cd $tmpdir

# Read the twix file into BART format
bart twixread -A "$infile" tmp1
# FFT on the first three dimensions 
bart fft -i -u $(bart bitmask 0 1 2) tmp1 tmp2
# calculate sum-of-squares combination of all channels to obtain one 3D dataset
bart rss $(bart bitmask 3) tmp2 tmp3
# cut out FOV center to remove the 2x readout oversampling 
bart crop 0 256 tmp3 tmp4
# write to dicoms
bart toimg tmp4 "$outdir/result.dcm"