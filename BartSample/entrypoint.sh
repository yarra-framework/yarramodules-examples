#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mode_section="BartSimple"

while [[ $# -gt 0 ]]; do case $1 in
  -i|--input-file) infile="$2"; shift;;
  -o|--output-dir) outdir="$2"; shift;;
  -t|--temp) tempdir="$2"; shift;;
  -d|--mode-file) modefile="$2"; shift;;
  -m|--matlab) matlab="$2"; shift;;
  -u|--modules) modules="$2"; shift;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done


if [ ! -f "$infile" ]; then
    echo "Input file $infile not found."
    exit 1;
fi

if [ ! -d "$outdir" ]; then
    echo "Output directory $outdir not found."
    exit 1;
fi

cd "$DIR"
./recon.sh "$tmpdir" "$infile" "$outdir"
