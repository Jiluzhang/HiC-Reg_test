## P1 1.5Sham
bamCompare -b1 ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham.bam -b2 ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5Sham_input.bam \
           --binSize 1 -p max -of bigwig -o P1_1.5Sham_log2ratio.bw
## P1 1.5MI
samtools merge -@ 50 H3K27ac.bam rep1/H3K27ac_WT_rep1_uniquely_rm.bam rep2/H3K27ac_WT_rep2_uniquely_rm.bam
samtools index -@ 50 H3K27ac.bam
bamCoverage -p 50 -of bedgraph --binSize 1 --normalizeUsing None -b H3K27ac.bam -o H3K27ac.bedgraph
