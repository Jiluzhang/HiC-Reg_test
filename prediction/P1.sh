## compare chromatin interactions for IREs nearby regions (±100kb)
## P1_1.5Sham
awk '{printf("chr"$1"\t");printf("%d\t", ($2+$3)*0.5/10000-10);printf("%d\t", ($2+$3)*0.5/10000+10);print("E_"NR)}' \
     mouse_heart_fc_1.5_fdr_0.05_RREs.bed > IREs_100kb.bed
bedtools intersect -a IREs_100kb.bed -b P1_1.5Sham/obs_kr.txt -wa -wb -F 1 > P1_1.5Sham_IREs.txt  # ~2 min
bedtools intersect -a IREs_100kb.bed -b P1_1.5MI/obs_kr.txt -wa -wb -F 1 > P1_1.5MI_IREs.txt

## P1_1.5MI
shuf ~/Heliyon/P1_1.5dpi_IREs_non_IREs_H3K27ac/non_RREs.bed | head -n 2000 | sort -k1,1 -k2,2n > non_IREs_random_2000.bed
awk '{printf($1"\t");printf("%d\t", ($2+$3)*0.5/10000-10);printf("%d\t", ($2+$3)*0.5/10000+10);print("NE_"NR)}' \
     non_IREs_random_2000.bed > non_IREs_random_2000_100kb.bed
bedtools intersect -a non_IREs_random_2000_100kb.bed -b P1_1.5Sham/obs_kr.txt -wa -wb -F 1 > P1_1.5Sham_non_IREs.txt  # ~2 min
bedtools intersect -a non_IREs_random_2000_100kb.bed -b P1_1.5MI/obs_kr.txt -wa -wb -F 1 > P1_1.5MI_non_IREs.txt
