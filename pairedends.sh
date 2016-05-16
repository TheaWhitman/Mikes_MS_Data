#!/bin/bash

# count raw (fwd & rev) reads
rm read-counts-raw.txt
touch read-counts-raw.txt
for name in $(cat ./names-file.txt)
do 
    echo $name >> read-counts-raw.txt
    grep @ ../$name | wc -l >> read-counts-raw.txt
done

# merge raw reads with PEAR, default min overlap is 10bp
# PEAR v0.9.9 [May 13, 2016]
# default min overlap = 10
for name in $(cat ./names-tube.txt)
do 
    pear -m 600 -j 20 -f ../run*$name*R1.fastq -r ../run*$name*R2.fastq -o ../pear-$name
done

# count merged reads
rm read-counts-merged.txt
touch read-counts-merged.txt
for name in $(cat ./names-tube.txt)
do 
    echo $name >> read-counts-merged.txt
    grep '>' ../pear-*$name*.fastq | wc -l >> read-counts-merged.txt
done
