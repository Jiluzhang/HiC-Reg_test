## mouse P1 CM H3K27ac & H3K27me3 ChIP-seq data are from "Postnatal state transition of cardiomyocyte as a primary step in heart maturation"
## GSE155658 (not public)
## GSE73771 ("EED orchestration of heart maturation through interaction with HDACs is H3K27me3-independent")

######### H3K27ac ChIP-seq data #############
# Illumina HiSeq 2500 sequencing; GSM1902461: H3K27ac_WT_rep1; Mus musculus; ChIP-Seq
# SRR2566302: 5e1bfa350e3acf37aa27b3e60024ccc2
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR256/002/SRR2566302/SRR2566302.fastq.gz .
mv SRR2566302.fastq.gz H3K27ac_WT_rep1.fastq.gz
nohup ChIPseq_mouse_single H3K27ac_WT_rep1 &
#20935600 reads; of these:
#  20935600 (100.00%) were unpaired; of these:
#    835623 (3.99%) aligned 0 times
#    15487000 (73.97%) aligned exactly 1 time
#    4612977 (22.03%) aligned >1 times
#96.01% overall alignment rate

# Illumina HiSeq 2500 sequencing; GSM1902462: H3K27ac_WT_rep2; Mus musculus; ChIP-Seq
# SRR2566303: 9dc35505c34e68a0b1b96abf0fd03dc3
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR256/003/SRR2566303/SRR2566303.fastq.gz .
mv SRR2566303.fastq.gz H3K27ac_WT_rep2.fastq.gz
nohup ChIPseq_mouse_single H3K27ac_WT_rep2 &
#23716566 reads; of these:
#  23716566 (100.00%) were unpaired; of these:
#    882316 (3.72%) aligned 0 times
#    17975009 (75.79%) aligned exactly 1 time
#    4859241 (20.49%) aligned >1 times
#96.28% overall alignment rate

## merge rep1 & rep2
samtools merge -@ 50 H3K27ac.bam rep1/H3K27ac_WT_rep1_uniquely_rm.bam rep2/H3K27ac_WT_rep2_uniquely_rm.bam
samtools index -@ 50 H3K27ac.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b H3K27ac.bam -o H3K27ac.bedgraph


########### H3K27me3 ChIP-seq data #############
# Illumina HiSeq 2500 sequencing; GSM1902475: H3K27me3_WT_rep1; Mus musculus; ChIP-Seq
# SRR2566316: cee4eafc3174195343090628f0b5b242
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR256/006/SRR2566316/SRR2566316.fastq.gz .
mv SRR2566316.fastq.gz H3K27me3_WT_rep1.fastq.gz
nohup ChIPseq_mouse_single H3K27me3_WT_rep1 &
#27805427 reads; of these:
#  27805427 (100.00%) were unpaired; of these:
#    830045 (2.99%) aligned 0 times
#    19737455 (70.98%) aligned exactly 1 time
#    7237927 (26.03%) aligned >1 times
#97.01% overall alignment rate

# Illumina HiSeq 2500 sequencing; GSM1902476: H3K27me3_WT_rep2; Mus musculus; ChIP-Seq
# SRR2566317: 85ef6f1ebdb06b638cd32ebc23f37fde
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR256/007/SRR2566317/SRR2566317.fastq.gz .
mv SRR2566317.fastq.gz H3K27me3_WT_rep2.fastq.gz
nohup ChIPseq_mouse_single H3K27me3_WT_rep2 &
#34383534 reads; of these:
#  34383534 (100.00%) were unpaired; of these:
#    844385 (2.46%) aligned 0 times
#    24420564 (71.02%) aligned exactly 1 time
#    9118585 (26.52%) aligned >1 times
#97.54% overall alignment rate

# Illumina HiSeq 2500 sequencing; GSM1902477: H3K27me3_WT_rep3; Mus musculus; ChIP-Seq
# SRR2566318: 19eed60ce4e5a6e784a94b840e4a0c5f
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR256/008/SRR2566318/SRR2566318.fastq.gz .
mv SRR2566318.fastq.gz H3K27me3_WT_rep3.fastq.gz
nohup ChIPseq_mouse_single H3K27me3_WT_rep3 &
#37213463 reads; of these:
#  37213463 (100.00%) were unpaired; of these:
#    1218922 (3.28%) aligned 0 times
#    26215518 (70.45%) aligned exactly 1 time
#    9779023 (26.28%) aligned >1 times
#96.72% overall alignment rate

## merge rep1 & rep2 & rep3
samtools merge -@ 50 H3K27me3.bam rep1/H3K27me3_WT_rep1_uniquely_rm.bam rep2/H3K27me3_WT_rep2_uniquely_rm.bam rep3/H3K27me3_WT_rep3_uniquely_rm.bam
samtools index -@ 50 H3K27me3.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b H3K27me3.bam -o H3K27me3.bedgraph


## P1 Hi-C data are from "DNA methylation signatures follow preformed chromatin compartments in cardiac myocytes"
## PRJNA378914 (resolution is not high: 40kb)
## adult (8weeks + 5weeks) mouse cardiac myocytes Hi-C data (resolution: 5kb)
## GSE96693 (GSM2544836	Control_HiC)

wget -c https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM2544nnn/GSM2544836/suppl/GSM2544836_No_Tx.hic  # 12.5Gb


################## train model ###############
bedtools makewindows -g ~/ref_genome/chrom_sizes/mm10.chrom.sizes -w 10000 > mm10_10kb.bed
awk '{print $1 "\t" "CONVERT" "\t" "gene" "\t" $2 "\t" $3-1 "\t" "." "\t" "+" "\t" "." "\t" $1"_"$2"_"($3-1)}' mm10_10kb.bed > mm10_10kb.txt
awk '{print("chr"$0)}' H3K27ac/H3K27ac.bedgraph > H3K27ac.counts
awk '{print("chr"$0)}' H3K27me3/H3K27me3.bedgraph > H3K27me3.counts


#### aggregation.sh
date
echo ..........start..........
for i in $(seq 1);do
  mkdir chr$i && cd chr$i
  
  ## aggregate H3K27ac signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27ac.counts > H3K27ac.counts
  aggregateSignal ../mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27ac.counts H3K27ac.txt
  
  ## aggregate H3K27me3 signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27me3.counts > H3K27me3.counts
  aggregateSignal ../mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27me3.counts H3K27me3.txt
  
  ## aggregate Hi-C interaction
  java -jar ~/softwares/juicer_tools_1.19.02.jar dump observed KR ../HiC/GSM2544836_No_Tx.hic $i $i BP 10000 | sed '1d' | \
  awk '{if($1!=$2 && ($2-$1)<=2000000 && ($3!="NaN")) print "chr'$i'_"$1"_"($1+10000) "\t" "chr'$i'_"$2"_"($2+10000) "\t" $3}' > counts_pairs.tab
  
  ## aggregate features
  mkdir out
  genDatasetsRH counts_pairs.tab 2000000 5 regionwise ../featurefiles.txt no out/ yes Window  # 5: foldcv
  
  ## train model
  mkdir out_2
  regForest -t out/train0.txt -o out_2/ -k1 -l10 -n20 -b ../prior_window.txt -d out/test0.txt
  
  echo ..........end..........
  date
  #echo chr$i Done
done


mkdir out_2
regForest -t out/train0.txt -o out_2/ -k1 -l10 -n20 -b ../prior_window.txt -d out/test0.txt








