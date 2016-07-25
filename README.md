Mike's MS Data

---

Install [PEAR](https://github.com/xflouris/PEAR).

```
unzip run747.zip
cd run747
gunzip *.gz
git clone https://github.com/michaeljbraus/Mikes_MS_Data
```

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
---

QIIME

Install [QIIME](http://qiime.org/install/install.html#installing-qiime-natively-with-a-minimal-base-install).

version 1.8.0

Run PEAR on all files:
```
./Mikes_MS_Data/pairedends.sh
```

Manually copy all PEAR console output to output.txt, then grep the assembled read %'s:
```
grep "Assembled" output.txt > assembled-percent.txt
```
