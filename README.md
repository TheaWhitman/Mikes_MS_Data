Mike's MS Data

Install [PEAR](https://github.com/xflouris/PEAR).

```
unzip run747.zip
cd run747
gunzip *.gz
git clone https://github.com/michaeljbraus/Mikes_MS_Data
cd Mikes_MS_Data
```

Run PEAR on all files.
```
./pairedends.sh
```

Manually copy all PEAR console output to output.txt
```
grep "Assembled" output.txt > assembled-percent.txt
```
