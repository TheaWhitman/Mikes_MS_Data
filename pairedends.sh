#!/bin/bash
# Merge raw reads with PEAR
# PEAR v0.9.9 [May 13, 2016]
for name in $(cat ./names-tube.txt)
do 
    pear -m 600 -j 20 -f ../run*$name*R1.fastq -r ../run*$name*R2.fastq -o ../pear-$name
done
