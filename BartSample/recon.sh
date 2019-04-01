#/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Invalid number of parameters"
    echo "Required: <tmpdir> <infile> <outdir>"
    exit 1
fi

cd $1

# Read the twix file into BART format
bart twixread -A "$2" tmp1
# FFT on the first three dimensions 
bart fft -i -u $(bart bitmask 0 1 2) tmp1 tmp2
# calculate sum-of-squares combination of all channels to obtain one 3D dataset
bart rss $(bart bitmask 3) tmp2 tmp3
# cut out FOV center to remove the 2x readout oversampling 
bart crop 0 256 tmp3 tmp4
# write to dicoms
bart toimg tmp4 "$3/result.dcm"