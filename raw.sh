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
