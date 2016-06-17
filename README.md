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

```
cp 
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
