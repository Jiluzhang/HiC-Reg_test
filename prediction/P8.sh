## compare chromatin interactions for IREs nearby regions (±100kb)
## P8_1.5Sham
bedtools intersect -a IREs_100kb.bed -b P8_1.5Sham/obs_kr.txt -wa -wb -F 1 > P8_1.5Sham_IREs.txt  # ~2 min
bedtools intersect -a IREs_100kb.bed -b P8_1.5MI/obs_kr.txt -wa -wb -F 1 > P8_1.5MI_IREs.txt

## P8_1.5MI
bedtools intersect -a non_IREs_random_2000_100kb.bed -b P8_1.5Sham/obs_kr.txt -wa -wb -F 1 > P8_1.5Sham_non_IREs.txt  # ~2 min
bedtools intersect -a non_IREs_random_2000_100kb.bed -b P8_1.5MI/obs_kr.txt -wa -wb -F 1 > P8_1.5MI_non_IREs.txt
