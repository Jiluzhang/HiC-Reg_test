## P1 1.5Sham
bamCompare -b1 ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham.bam -b2 ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5Sham_input.bam \
           --binSize 1 -p max -of bigwig -o P1_1.5Sham_log2ratio.bw  # ~20min

## P1 1.5MI
samtools merge -@ 50 P1_1.5MI.bam P1_1.5MI_rep1/P1_1.5MI_rep1_uniquely_rm.bam P1_1.5MI_rep2/P1_1.5MI_rep2_uniquely_rm.bam
samtools index -@ 50 P1_1.5MI.bam
bamCompare -b1 ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5MI.bam -b2 ~/ChIP_seq/mouse/P1_heart/H3K27ac/P1_1.5MI_input.bam \
           --binSize 1 -p max -of bigwig -o P1_1.5MI_log2ratio.bw

## P8 1.5Sham
samtools merge -@ 50 P8_1.5Sham.bam P8_1.5Sham_rep1/P8_1.5Sham_rep1_H3K27me3_uniquely_rm.bam P8_1.5Sham_rep2/P8_1.5Sham_rep2_H3K27me3_uniquely_rm.bam
samtools index -@ 50 P8_1.5Sham.bam
bamCompare -b1 ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5Sham.bam -b2 ~/ChIP_seq/mouse/P8_heart/H3K27ac/P8_1.5Sham_input.bam \
           --binSize 1 -p max -of bigwig -o P8_1.5Sham_log2ratio.bw

## P8 1.5MI
samtools merge -@ 50 P8_1.5MI.bam P8_1.5MI_rep1/P8_1.5MI_rep1_H3K27me3_uniquely_rm.bam P8_1.5MI_rep2/P8_1.5MI_rep2_H3K27me3_uniquely_rm.bam
samtools index -@ 50 P8_1.5MI.bam
bamCompare -b1 ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5MI.bam -b2 ~/ChIP_seq/mouse/P8_heart/H3K27ac/P8_1.5MI_input.bam \
           --binSize 1 -p max -of bigwig -o P8_1.5MI_log2ratio.bw

