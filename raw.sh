## datasource I:  https://zenodo.org/record/3525432#.YpAfHpNBxQN
## datasource II: https://zenodo.org/record/3525510#.YpAfW5NBxQM
wget -c https://zenodo.org/record/3525432/files/Hmec.tgz?download=1
tar -zxvf Hmec.tgz\?download\=1  # generate "Hmec" directory


## download HiC-Reg
wget -c https://github.com/Roy-lab/HiC-Reg/archive/refs/heads/master.zip
unzip master.zip  # HiC-Reg-master


## 1.0 aggregate region-level features (wkdir: Scripts/aggregateSignallnRegion)
chmod +x aggregateSignal
./aggregateSignal hg19_5kbp_chr17.txt hg19.fa.fai wgEncodeBroadHistoneGm12878CtcfStdRawDataRep1_chr17.counts wgEncodeBroadHistoneGm12878CtcfStdRawDataRep1_chr17.txt
# ./aggregateSignal: error while loading shared libraries: libgsl.so.0: cannot open shared object file: No such file or directory

## debug ##
## GNU Scientific Library(GSL): a numerical library for C and C++ programmers (https://www.gnu.org/software/gsl/).
## https://www.songbingjia.com/ios/show-18738.html
wget -c https://mirror.ibcp.fr/pub/gnu/gsl/gsl-latest.tar.gz
tar -zxvf gsl-latest.tar.gz
cd gsl-2.7.1
./configure --prefix=/share/home/jlz21/softwares/gsl (without root permission)
make
make install 
vi ~/.bashrc
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/softwares/gsl/lib
#export CFLAGS="-I/~/softwares/gsl/include"
#export LDFLAGS="-L/softwares/gsl/lib"
source ~/.bashrc
cd ~/softwares/gsl/lib
ln libgsl.so libgsl.so.0


## 1.1 generate PAIR-CONCAT or WINDOW features (wkdir: Scripts/genPairFeatures)
./genDatasetsRH Gm12878_chr17_5kb_SQRTVC_counts_pairs_100.tab 1000000 5 regionwise Gm12878_norm_featurefiles_test.txt no out/ yes Window

## 1.2 generate MULTI-CELL features (wkdir: Scripts/genMULTICELLfeats)
python3 gen-MULTICELL-features.py --inpath ./ --chr 17 --ncv 2 --outpath ./
# "train_range=range(0,fold*validation_set_size)+range((fold+1)*validation_set_size,n)" ->
# "train_range = list(range(0,fold*validation_set_size)) + list(range((fold+1)*validation_set_size,n))"

## 2.1 training mode (wkdir: Code/)
./regForest -t ../Examples/Data/Gm12878_chr17_WINDOW_train0.txt -o ../Examples/out_2/ -k1 -l10 -n20 -b ../Examples/Data/prior_window.txt -d ../Examples/Data/Gm12878_chr17_WINDOW_test0.txt

## debug ##
# Code/Makefile
# "LIBPATH = /mnt/ws/sysbio/roygroup/shared/thirdparty/gsl_install/lib
# INCLPATH2 =/mnt/ws/sysbio/roygroup/shared/thirdparty/gsl_install/include"  ->
# "LIBPATH = ~/softwares/gsl/lib
# INCLPATH2 = ~/softwares/gsl/include"
make

## 2.2 prediction mode (wkdir: Code/)
# gm12878 -> gm12878
./regForest -t ../Examples/Data/Gm12878_chr17_WINDOW_train0.txt -o ../Examples/out_2/ -k1 -l10 -n20 -b ../Examples/Data/prior_window.txt -d ../Examples/Data/Gm12878_chr17_WINDOW_test0.txt -s ../Examples/out/regtree_node
# gm12878 -> k562
./regForest -t ../Examples/Data/Gm12878_chr17_WINDOW_train0.txt -o ../Examples/out_3/ -k1 -l10 -n20 -b ../Examples/Data/prior_window.txt -d ../Examples/Data/K562_chr17_WINDOW_test0.txt


## subtract 1
bedtools makewindows -g ~/ref_genome/chrom_sizes/mm10.chrom.sizes -w 100000 > mm10_100kb.bed
awk '{print $1 "\t" "CONVERT" "\t" "gene" "\t" $2 "\t" $3-1 "\t" "." "\t" "+" "\t" "." "\t" $1"_"$2"_"($3-1)}' mm10_100kb.bed > mm10_100kb.txt
time bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5Sham_uniquely_rm.bam -o P1_1.5Sham.bedgraph
awk '{if($4!=0) print("chr"$0)}' P1_1.5Sham.bedgraph > P1_1.5Sham.counts

awk '{if($1=="chr1") print $0}' P1_1.5Sham.counts > P1_1.5Sham_chr1.counts
./aggregateSignal mm10_100kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai P1_1.5Sham_chr1.counts P1_1.5Sham_chr1.txt
java -jar ~/softwares/juicer_tools_1.19.02.jar dump observed KR ~/C_data/Hi_C/mouse/heart/newborn.allValidPairs.hic 1 1 BP 100000 | sed '1d' |\
awk '{if($1!=$2) print "chr1_"$1"_"($1+100000) "\t" "chr1_"$2"_"($2+100000) "\t" $3}' > P1_1.5Sham_chr1_counts_pairs.tab

./genDatasetsRH P1_1.5Sham_chr1_counts_pairs.tab 1000000 5 pairwise featurefiles.txt no out/ yes Window



## not subtract 1
awk '{print $1 "\t" "CONVERT" "\t" "gene" "\t" $2 "\t" $3 "\t" "." "\t" "+" "\t" "." "\t" $1"_"$2"_"($3)}' mm10_100kb.bed > mm10_100kb.txt
awk '{if($4!=0) print("chr"$0)}' P1_1.5Sham.bedgraph > P1_1.5Sham.counts

awk '{if($1=="chr1") print $0}' P1_1.5Sham.counts > P1_1.5Sham_chr1.counts
./aggregateSignal mm10_100kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai P1_1.5Sham_chr1.counts P1_1.5Sham_chr1.txt

./genDatasetsRH P1_1.5Sham_chr1_counts_pairs.tab 1000000 5 pairwise featurefiles.txt no out/ yes Window
## !!!!!!!!!!!!!!!!!!!directory out must be created before running genDatasetsRH!!!!!!!!!!!!!!!!!!!!!!!!!!!


grep chr17 Gm12878_RawData_5000bp_seqdepth_norm_H3k4me1.txt | cut -d _ -f 1,2 > tmp_1.txt
grep chr17 Gm12878_RawData_5000bp_seqdepth_norm_H3k4me1.txt | cut -d _ -f 3 | awk '{print "_" $1+1 "\t" $2}' > tmp_2.txt
paste -d "" tmp_1.txt tmp_2.txt > H3k4me1_chr17.txt
rm tmp_1.txt tmp_2.txt
sed -i '1 i Gene\tH3k4me1' H3k4me1_chr17.txt

grep chr17 Gm12878_RawData_5000bp_seqdepth_norm_H3k4me2.txt | cut -d _ -f 1,2 > tmp_1.txt
grep chr17 Gm12878_RawData_5000bp_seqdepth_norm_H3k4me2.txt | cut -d _ -f 3 | awk '{print "_" $1+1 "\t" $2}' > tmp_2.txt
paste -d "" tmp_1.txt tmp_2.txt > H3k4me2_chr17.txt
rm tmp_1.txt tmp_2.txt
sed -i '1 i Gene\tH3k4me2' H3k4me2_chr17.txt


## Makefile (for genDatasetsRH)
SRC=Dataset.C Distance.C Framework.C
#INCLPATH1=common
LIBPATH = ~/softwares/gsl/lib
INCLPATH2 =~/softwares/gsl/include

LOCLIB=/home/dchasman/cmint_ashton_v3/learntrees/execs/learnpertarget/lib
LOCINCL=/home/dchasman/cmint_ashton_v3/learntrees/execs/learnpertarget/include

CC=g++
CFLAGS = -g -std=c++0x
LFLAG = -lgsl -lgslcblas 

#local: $(SRC)
#	$(CC) $(SRC) -I $(INCLPATH1) -I $(LOCINCL)  -L $(LOCLIB) $(LFLAG) $(CFLAGS) -o regTreeDC

ALL: $(SRC)
	$(CC) $(SRC) -I $(INCLPATH2)  -L $(LIBPATH) $(LFLAG) $(CFLAGS) -o test
clean:
	rm test


## debug orders
#splitPairs -> splitRegionsGenPairs        -> showFeaturesPair
#              generateFeatureFiles_Concat -> showFeatures



bedtools makewindows -g ~/ref_genome/chrom_sizes/mm10.chrom.sizes -w 10000 > mm10_100kb.bed
awk '{print $1 "\t" "CONVERT" "\t" "gene" "\t" $2 "\t" $3-1 "\t" "." "\t" "+" "\t" "." "\t" $1"_"$2"_"($3-1)}' mm10_100kb.bed > mm10_100kb.txt
time bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5Sham_uniquely_rm.bam -o P1_1.5Sham.bedgraph
awk '{if($4!=0) print("chr"$0)}' P1_1.5Sham.bedgraph > P1_1.5Sham.counts

awk '{if($1=="chr1") print $0}' P1_1.5Sham.counts > P1_1.5Sham_chr1.counts
./aggregateSignal mm10_100kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai P1_1.5Sham_chr1.counts P1_1.5Sham_chr1.txt
java -jar ~/softwares/juicer_tools_1.19.02.jar dump observed KR ~/C_data/Hi_C/mouse/heart/newborn.allValidPairs.hic 1 1 BP 100000 | sed '1d' |\
awk '{if($1!=$2) print "chr1_"$1"_"($1+100000) "\t" "chr1_"$2"_"($2+100000) "\t" $3}' > P1_1.5Sham_chr1_counts_pairs.tab

./genDatasetsRH P1_1.5Sham_chr1_counts_pairs.tab 1000000 5 regionwise featurefiles.txt no out/ yes Window  ## not use pairwise
./regForest -t out/train0.txt -o out/ -k1 -l10 -n20 -b prior_window.txt -d out/test0.txt


head -n 1 train0.txt > train0_tmp.txt
sed '1d' train0.txt | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7*10}' >> train0_tmp.txt
head -n 1 test0.txt > test0_tmp.txt
sed '1d' test0.txt | awk '{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7*10}' >> test0_tmp.txt




