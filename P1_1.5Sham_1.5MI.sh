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

for i in $(seq 1);do
  mkdir chr$i && cd chr$i
  
  ## aggregate H3K27ac signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27ac.counts > H3K27ac.counts
  aggregateSignal ~/Heliyon/3d_genome_prediction/hicreg/mouse/mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27ac.counts H3K27ac.txt
  
  ## aggregate H3K27me3 signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27me3.counts > H3K27me3.counts
  aggregateSignal ~/Heliyon/3d_genome_prediction/hicreg/mouse/mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27me3.counts H3K27me3.txt
  
  ## aggregate features
  mkdir out
  genDatasetsRH ~/Heliyon/3d_genome_prediction/hicreg/mouse/chr1/counts_pairs.tab 2000000 1 regionwise \
                ~/Heliyon/3d_genome_prediction/hicreg/mouse/featurefiles.txt no out/ yes Window
  
  ## make prediction
  mkdir pred
  regForest -t out/test0.txt -o pred -k1 -l10 -n20 -b ~/Heliyon/3d_genome_prediction/hicreg/mouse/prior_window.txt \
            -d out/test0.txt -s ~/Heliyon/3d_genome_prediction/hicreg/mouse/chr1/out_2/regtree_node
  
  echo ..........end..........
  date
  #echo chr$i Done
done







####### P1_1.5MI H3K27ac
samtools merge -@ 50 P1_1.5MI.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5MI_rep1/P1_1.5MI_rep1_uniquely_rm.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5MI_rep2/P1_1.5MI_rep2_uniquely_rm.bam
samtools index -@ 50 P1_1.5MI.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b P1_1.5MI.bam -o P1_1.5MI.bedgraph

####### P1_1.5MI H3K27me3
samtools merge -@ 50 P1_1.5MI.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5MI_rep1/P1_1.5MI_rep1_uniquely_rm.bam \
                     ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5MI_rep2/P1_1.5MI_rep2_uniquely_rm.bam
samtools index -@ 50 P1_1.5MI.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b P1_1.5MI.bam -o P1_1.5MI.bedgraph

awk '{print("chr"$0)}' H3K27ac/P1_1.5MI.bedgraph > H3K27ac.counts
awk '{print("chr"$0)}' H3K27me3/P1_1.5MI.bedgraph > H3K27me3.counts

for i in $(seq 1);do
  mkdir chr$i && cd chr$i
  
  ## aggregate H3K27ac signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27ac.counts > H3K27ac.counts
  aggregateSignal ~/Heliyon/3d_genome_prediction/hicreg/mouse/mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27ac.counts H3K27ac.txt
  
  ## aggregate H3K27me3 signal
  awk '{if($1=="chr'$i'") print $0}' ../H3K27me3.counts > H3K27me3.counts
  aggregateSignal ~/Heliyon/3d_genome_prediction/hicreg/mouse/mm10_10kb.txt ~/ref_genome/Mus_musculus/mm10.fa.fai H3K27me3.counts H3K27me3.txt
  
  ## aggregate features
  mkdir out
  genDatasetsRH ~/Heliyon/3d_genome_prediction/hicreg/mouse/chr1/counts_pairs.tab 2000000 1 regionwise \
                ~/Heliyon/3d_genome_prediction/hicreg/mouse/featurefiles.txt no out/ yes Window
  
  ## make prediction
  mkdir pred
  regForest -t out/test0.txt -o pred -k1 -l10 -n20 -b ~/Heliyon/3d_genome_prediction/hicreg/mouse/prior_window.txt \
            -d out/test0.txt -s ~/Heliyon/3d_genome_prediction/hicreg/mouse/chr1/out_2/regtree_node
  
  echo ..........end..........
  date
  #echo chr$i Done
done
