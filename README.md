Mike's MS Data

---

mothur

Install [mothur](https://github.com/mothur/mothur/releases)

v.1.37.5

Move all "clado" files for mothur into run747. 
`cp clado.* ~/run747/`

mothur [MiSeq_SOP](http://www.mothur.org/wiki/MiSeq_SOP)

```
mothur > count.groups(group=clado.contigs.groups)
C172N1 contains 323763.
C172N2 contains 226990.
C172N3 contains 255187.
C172P1 contains 173256.
C172P2 contains 224496.
C172P3 contains 227369.
C172S1 contains 240272.
C172S2 contains 217685.
C172S3 contains 243121.
C178N1 contains 325382.
C178N2 contains 251100.
C178N3 contains 163327.
C178P1 contains 232330.
C178P2 contains 269780.
C178P3 contains 278032.
C178S1 contains 229612.
C178S2 contains 279025.
C178S3 contains 295394.
C185N1 contains 261620.
C185N2 contains 180638.
C185N3 contains 234084.
C185P1 contains 303002.
C185P2 contains 280207.
C185P3 contains 243827.
C185S1 contains 301625.
C185S2 contains 250649.
C185S3 contains 304315.
C199N1 contains 176162.
C199N2 contains 222988.
C199N3 contains 294976.
C199P1 contains 293074.
C199P2 contains 224631.
C199P3 contains 312017.
C199S1 contains 279781.
C199S2 contains 267619.
C199S3 contains 176022.
C206N1 contains 224980.
C206N2 contains 368439.
C206N3 contains 329848.
C206P1 contains 268858.
C206P2 contains 372682.
C206S1 contains 297475.
C206S2 contains 236731.
C214N1 contains 207537.
C214N2 contains 188611.
C214N3 contains 382362.
C214P1 contains 275497.
C214P2 contains 229515.
C214P3 contains 352763.
C214S1 contains 282770.
C214S2 contains 256622.
C214S3 contains 145348.

Total seqs: 13483396.

mothur > summary.seqs(fasta=clado.trim.contigs.fasta, processors = 50)

Using 50 processors.

		Start	End	NBases	Ambigs	Polymer	NumSeqs
Minimum:	1	246	246	0	3	1
2.5%-tile:	1	438	438	0	4	337085
25%-tile:	1	441	441	0	4	3370850
Median: 	1	460	460	0	5	6741699
75%-tile:	1	464	464	0	6	10112548
97.5%-tile:	1	489	489	5	12	13146312
Maximum:	1	502	502	77	251	13483396
Mean:	1	455.607	455.607	0.446866	5.2453
# of Seqs:	13483396

```
```
mothur > count.seqs(name=current, group=current)
Using clado.contigs.good.groups as input file for the group parameter.
Using clado.trim.contigs.good.names as input file for the name parameter.

Using 50 processors.
It took 123 secs to create a table for 11115326 sequences.


Total number of sequences: 11115326

Output File Names: 
clado.trim.contigs.good.count_table


mothur > summary.seqs(count=clado.trim.contigs.good.count_table)
Using clado.trim.contigs.good.unique.fasta as input file for the fasta parameter.

Using 50 processors.

		Start	End	NBases	Ambigs	Polymer	NumSeqs
Minimum:	1	248	248	0	3	1
2.5%-tile:	1	438	438	0	4	277884
25%-tile:	1	441	441	0	4	2778832
Median: 	1	460	460	0	5	5557664
75%-tile:	1	462	462	0	6	8336495
97.5%-tile:	1	465	465	0	6	10837443
Maximum:	1	475	475	0	209	11115326
Mean:	1	454.559	454.559	0	4.94141
# of unique seqs:	5071916
total # of seqs:	11115326

Output File Names: 
clado.trim.contigs.good.unique.summary

It took 79 secs to summarize 11115326 sequences.
```

Using align.seqs() requires knowing the position of your 16S amplicons (see [this blog post](http://blog.mothur.org/2016/07/07/Customization-for-your-region/) by Pat Schloss) in the Silva database, which has a lot of gaps. 16S is usually ~1,500 bases while Silva is ~50,000 characters. 

```
align.seqs(fasta=ecoli_v3.fasta, reference=silva.seed_v123.align)
summary.seqs(fasta=ecoli_v3v4.align)

                Start   End     NBases  Ambigs  Polymer NumSeqs
Minimum:        6334    25432   471     0       6       1
2.5%-tile:      6334    25432   471     0       6       1
25%-tile:       6334    25432   471     0       6       1
Median:         6334    25432   471     0       6       1
75%-tile:       6334    25432   471     0       6       1
97.5%-tile:     6334    25432   471     0       6       1
Maximum:        6334    25432   471     0       6       1
Mean:   6334    25432   471     0       6
# of Seqs:      1
```

Enter the Silva positions to trim the reference alignment and save on computing: 

`pcr.seqs(fasta=silva.bacteria.fasta, start=6334, end=25432, keepdots=F, processors=8)`

```
...
                Start   End     NBases  Ambigs  Polymer NumSeqs
Minimum:        1       19098   425     0       3       1
2.5%-tile:      52      19098   445     0       4       374
25%-tile:       52      19098   448     0       4       3740
Median:         52      19098   467     0       5       7479
75%-tile:       52      19098   470     0       5       11218
97.5%-tile:     52      19098   471     1       6       14583
Maximum:        53      19098   512     5       9       14956
Mean:   51.9631 19098   460.356 0.103036        4.86734
# of Seqs:      14956

...
Median:         54      18982   460     0       5       2535959
75%-tile:       54      18982   464     0       6       3803938
97.5%-tile:     54      18982   466     0       7       4945119
Maximum:        19098   19098   475     0       209     5071916
Mean:   232.908 18938.3 450.748 0       4.9889
# of Seqs:      5071916
```
So 54 and 18982 become the start and end for screen.seqs():
`screen.seqs(fasta=current, count=current, start=54, end=18982, maxhomop=8)`

Summary of filter.seqs():
```
Length of filtered alignment: 1448
Number of columns removed: 17650
Length of the original alignment: 19098
Number of sequences used to construct filter: 4849150
```

Opted to use 4 differences between sequences instead of 2 because these assembled reads are ~460nt. Schloss MiSeq_SOP: "We generally favor allowing 1 difference for every 100 bp of sequence."

`pre.cluster(fasta=current, count=current, diffs=4)`

...
```
> summary.seqs(fasta=clado.trim.contigs.good.unique.good.filter.unique.precluster.fasta, processors=50)
                Start   End     NBases  Ambigs  Polymer NumSeqs
Minimum:        1       1446    418     0       3       1
2.5%-tile:      1       1448    439     0       4       1057
25%-tile:       1       1448    441     0       4       10562
Median:         1       1448    460     0       5       21124
75%-tile:       1       1448    461     0       6       31685
97.5%-tile:     1       1448    465     0       7       41190
Maximum:        2       1448    475     0       8       42246
Mean:   1.00014 1448    454.301 0       5.00405
# of Seqs:      42246
```


---
Want to just assemble the paired-end reads? 

Install [PEAR](https://github.com/xflouris/PEAR).

```
unzip run747.zip
cd run747
gunzip *.gz
git clone https://github.com/michaeljbraus/Mikes_MS_Data
```

Example: 

Run PEAR on all files:
```
./Mikes_MS_Data/pairedends.sh
```

Manually copy all PEAR console output to output.txt, then grep the assembled read %'s:
```
grep "Assembled" output.txt > assembled-percent.txt
```
