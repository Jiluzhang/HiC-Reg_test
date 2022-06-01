####### P1_1.5Sham H3K27ac
samtools merge -@ 50 P1_1.5Sham.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5Sham_rep1/P1_1.5Sham_rep1_uniquely_rm.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5Sham_rep2/P1_1.5Sham_rep2_uniquely_rm.bam
samtools index -@ 50 P1_1.5Sham.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b P1_1.5Sham.bam -o P1_1.5Sham.bedgraph

####### P1_1.5Sham H3K27me3
samtools merge -@ 50 P1_1.5Sham.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham_rep1/P1_1.5Sham_rep1_uniquely_rm.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham_rep2/P1_1.5Sham_rep2_uniquely_rm.bam
samtools index -@ 50 P1_1.5Sham.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b P1_1.5Sham.bam -o P1_1.5Sham.bedgraph

awk '{print("chr"$0)}' H3K27ac/P1_1.5Sham.bedgraph > H3K27ac.counts
awk '{print("chr"$0)}' H3K27me3/P1_1.5Sham.bedgraph > H3K27me3.counts


####### aggregate_predict.sh
for i in $(seq 19) X;do
  echo ........chr$i start.........
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