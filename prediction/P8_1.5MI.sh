####### P8_1.5MI H3K27ac
samtools merge -@ 50 P8_1.5MI.bam \
                     ~/ChIP_seq/mouse/P8_heart/H3K27ac/P8_1.5MI_rep1/P8_1.5MI_rep1_uniquely_rm.bam \
                     ~/ChIP_seq/mouse/P8_heart/H3K27ac/P8_1.5MI_rep2/P8_1.5MI_rep2_uniquely_rm.bam
samtools index -@ 50 P8_1.5MI.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b P8_1.5MI.bam -o P8_1.5MI.bedgraph


####### P8_1.5MI H3K27me3
# NextSeq 500 sequencing; GSM3514899: P8_1.5MI_rep1_H3K27me3; Mus musculus; ChIP-Seq
# SRR8318829: 42a1a383adf4da2670c2db405edadab4
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR831/009/SRR8318829/SRR8318829.fastq.gz .
mv SRR8318829.fastq.gz P8_1.5MI_rep1_H3K27me3.fastq.gz
nohup ChIPseq_mouse_single P8_1.5MI_rep1_H3K27me3 &

# NextSeq 500 sequencing; GSM3514900: P8_1.5MI_rep2_H3K27me3; Mus musculus; ChIP-Seq
# SRR8318830: 9d45f1c93b5291a9f94876a787df6cf0
ascp -QT -l 300m -P33001 -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh \
era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR831/000/SRR8318830/SRR8318830.fastq.gz .
mv SRR8318830.fastq.gz P8_1.5MI_rep2_H3K27me3.fastq.gz
nohup ChIPseq_mouse_single P8_1.5MI_rep2_H3K27me3 &

samtools merge -@ 50 P8_1.5MI.bam \
                     ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5MI_rep1/P8_1.5MI_rep1_H3K27me3_uniquely_rm.bam \
                     ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5MI_rep2/P8_1.5MI_rep2_H3K27me3_uniquely_rm.bam
samtools index -@ 50 P8_1.5MI.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b P8_1.5MI.bam -o P8_1.5MI.bedgraph

awk '{print("chr"$0)}' H3K27ac/P8_1.5MI.bedgraph > H3K27ac.counts
awk '{print("chr"$0)}' H3K27me3/P8_1.5MI.bedgraph > H3K27me3.counts


####### aggregate_predict.sh
for i in $(seq 19) X;do
  echo ........chr$i start.........
  
  cd ~/Heliyon/3d_genome_prediction/hicreg/mouse/test/P8_1.5MI
  mkdir chr$i && cd chr$i
  
  ## aggregate H3K27ac signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27ac.counts > H3K27ac.counts
  aggregateSignal ~/Heliyon/3d_genome_prediction/hicreg/mouse/train/mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27ac.counts H3K27ac.txt
  
  ## aggregate H3K27me3 signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27me3.counts > H3K27me3.counts
  aggregateSignal ~/Heliyon/3d_genome_prediction/hicreg/mouse/train/mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27me3.counts H3K27me3.txt
  
  ## aggregate features
  mkdir data
  genDatasetsRH ~/Heliyon/3d_genome_prediction/hicreg/mouse/train/chr$i/counts_pairs.tab 2000000 1 regionwise \
                ~/Heliyon/3d_genome_prediction/hicreg/mouse/train/featurefiles.txt no data/ yes Window
  
  ## make prediction
  mkdir pred
  regForest -t data/test0.txt -o pred -k1 -l10 -n20 -b ~/Heliyon/3d_genome_prediction/hicreg/mouse/train/prior_window.txt \
            -d data/test0.txt -s ~/Heliyon/3d_genome_prediction/hicreg/mouse/train/chr$i/model/regtree_node
  
  echo ..........chr$i end..........
done


## concat_obs_kr.sh
for i in $(seq 19) X;do
  cd ~/Heliyon/3d_genome_prediction/hicreg/mouse/test/P8_1.5MI/chr$i/pred
  awk '{print $1}' testset_error.txt | sed '1d' | cut -d _ -f 1,2,4 --output-delimiter $'\t' > idx.txt
  sed '1d' testset_error.txt | awk '{printf("%.2f\n", $3)}' > val.txt
  paste idx.txt val.txt | awk '{print $1 "\t" $2/10000 "\t" $3/10000 "\t" $4}' >> ~/Heliyon/3d_genome_prediction/hicreg/mouse/test/P8_1.5MI/obs_kr.txt
  rm idx.txt val.txt
  echo chr$i done
done
