## compare chromatin interactions for IREs nearby regions (±100kb)
## P8_1.5Sham
bedtools intersect -a IREs_100kb.bed -b P8_1.5Sham/obs_kr.txt -wa -wb -F 1 > P8_1.5Sham_IREs.txt  # ~2 min
bedtools intersect -a IREs_100kb.bed -b P8_1.5MI/obs_kr.txt -wa -wb -F 1 > P8_1.5MI_IREs.txt

## P8_1.5MI
bedtools intersect -a non_IREs_random_2000_100kb.bed -b P8_1.5Sham/obs_kr.txt -wa -wb -F 1 > P8_1.5Sham_non_IREs.txt  # ~2 min
bedtools intersect -a non_IREs_random_2000_100kb.bed -b P8_1.5MI/obs_kr.txt -wa -wb -F 1 > P8_1.5MI_non_IREs.txt


## generate obs for IRE-gene pairs
bedtools intersect -a IREs_genes_bin.txt -b P8_1.5Sham/obs_kr.txt -wa -wb -f 1 -r | uniq > P8_1.5Sham_IREs_genes.txt  # 1268
bedtools intersect -a IREs_genes_bin.txt -b P8_1.5MI/obs_kr.txt -wa -wb -f 1 -r | uniq > P8_1.5MI_IREs_genes.txt  # 1268


## generate obs for non_IRE-gene pairs
bedtools intersect -a non_IREs_genes_bin.txt -b P8_1.5Sham/obs_kr.txt -wa -wb -f 1 -r | uniq > P8_1.5Sham_non_IREs_genes.txt  # 1650
bedtools intersect -a non_IREs_genes_bin.txt -b P8_1.5MI/obs_kr.txt -wa -wb -f 1 -r | uniq > P8_1.5MI_non_IREs_genes.txt  # 1650
