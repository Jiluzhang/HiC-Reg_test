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


## normalized by input
computeMatrix reference-point --referencePoint center -p 40 -S P1_1.5Sham_log2ratio.bw P1_1.5MI_log2ratio.bw \
              -R RREs.bed -o H3K27me3_RREs_P1_1.5_log2ratio.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_RREs_P1_1.5_log2ratio.gz --yMin -0.6 --yMax 0.1 --dpi 600 -out H3K27me3_RREs_P1_1.5_log2ratio.pdf

computeMatrix reference-point --referencePoint center -p 40 -S P8_1.5Sham_log2ratio.bw P8_1.5MI_log2ratio.bw \
              -R RREs.bed -o H3K27me3_RREs_P8_1.5_log2ratio.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_RREs_P8_1.5_log2ratio.gz --yMin -0.6 --yMax 0.1 --dpi 600 -out H3K27me3_RREs_P8_1.5_log2ratio.pdf

computeMatrix reference-point --referencePoint center -p 40 -S P1_1.5Sham_log2ratio.bw P1_1.5MI_log2ratio.bw \
              -R non_RREs.bed -o H3K27me3_non_RREs_P1_1.5_log2ratio.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_non_RREs_P1_1.5_log2ratio.gz --yMin -0.6 --yMax 0.1 --dpi 600 -out H3K27me3_non_RREs_P1_1.5_log2ratio.pdf

computeMatrix reference-point --referencePoint center -p 40 -S P8_1.5Sham_log2ratio.bw P8_1.5MI_log2ratio.bw \
              -R non_RREs.bed -o H3K27me3_non_RREs_P8_1.5_log2ratio.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_non_RREs_P8_1.5_log2ratio.gz --yMin -0.6 --yMax 0.1 --dpi 600 -out H3K27me3_non_RREs_P8_1.5_log2ratio.pdf


## not normalized by input
# P1
bamCoverage -p 50 -of bigwig --binSize 1 --normalizeUsing RPKM -b P1_1.5MI.bam -o P1_1.5MI.bw

computeMatrix reference-point --referencePoint center -p 40 -S ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham.bw \
                                                               ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5MI.bw \
              -R RREs.bed -o H3K27me3_RREs_P1_1.5_signal.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_RREs_P1_1.5_signal.gz --yMin 20 --yMax 40 --dpi 600 -out H3K27me3_RREs_P1_1.5_signal.pdf

computeMatrix reference-point --referencePoint center -p 40 -S ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham.bw \
                                                               ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5MI.bw \
              -R non_RREs.bed -o H3K27me3_non_RREs_P1_1.5_signal.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_non_RREs_P1_1.5_signal.gz --yMin 20 --yMax 40 --dpi 600 -out H3K27me3_non_RREs_P1_1.5_signal.pdf

# P8
bamCoverage -p 50 -of bigwig --binSize 1 --normalizeUsing RPKM -b P8_1.5Sham.bam -o P8_1.5Sham.bw
bamCoverage -p 50 -of bigwig --binSize 1 --normalizeUsing RPKM -b P8_1.5MI.bam -o P8_1.5MI.bw

computeMatrix reference-point --referencePoint center -p 40 -S ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5Sham.bw \
                                                               ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5MI.bw \
              -R RREs.bed -o H3K27me3_RREs_P8_1.5_signal.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_RREs_P8_1.5_signal.gz --yMin 20 --yMax 40 --dpi 600 -out H3K27me3_RREs_P8_1.5_signal.pdf

computeMatrix reference-point --referencePoint center -p 40 -S ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5Sham.bw \
                                                               ~/ChIP_seq/mouse/P8_heart/H3K27me3/P8_1.5MI.bw \
              -R non_RREs.bed -o H3K27me3_non_RREs_P8_1.5_signal.gz -a 2000 -b 2000 -bs 10
plotProfile --perGroup -m H3K27me3_non_RREs_P8_1.5_signal.gz --yMin 20 --yMax 40 --dpi 600 -out H3K27me3_non_RREs_P8_1.5_signal.pdf


# RREs random shuffle
#bedtools shuffle -i RREs.bed -g ~/ref_genome/chrom_sizes/mm10.chrom.sizes -seed 0 > RREs_random.bed
#computeMatrix reference-point --referencePoint center -p 40 -S ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5Sham.bw \
#                                                               ~/ChIP_seq/mouse/P1_heart/H3K27me3/P1_1.5MI.bw \
#              -R RREs_random.bed -o tmp.gz -a 2000 -b 2000 -bs 10
#plotProfile --perGroup -m tmp.gz --yMin 20 --yMax 40 --dpi 600 -out tmp.pdf
