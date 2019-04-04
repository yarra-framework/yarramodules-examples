#!/bin/bash
set -eo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mode_section="MatlabSample"
recon_method="sample_yarra_recon"

while [[ $# -gt 0 ]]; do case $1 in
  -i|--input-file) infile="$2"; shift;;
  -o|--output-dir) outdir="$2"; shift;;
  -t|--temp) tempdir="$2"; shift;;
  -d|--mode-file) modefile="$2"; shift;;
  -m|--matlab) matlab="$2"; shift;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done

if [ ! -f $matlab ]; then
   if [ ! $( builtin type -P "$matlab" ) ]; then
       echo "Matlab binary \"$matlab\" not found."
       exit 1;
   fi
fi

if [ ! -f $infile ]; then
    echo "Input file \"$infile\" not found."
    exit 1;
fi

if [ ! -d "$outdir" ]; then
    echo "Output directory \"$outdir\" not found."
    exit 1;
fi

exec "$matlab" -nodesktop -nosplash -nojvm -r "\
try, addpath(genpath('$DIR/src')); \
   $recon_method('$infile','$outdir','$tempdir'); \
catch e, disp(getReport(e,'extended')); end, \
quit;"
