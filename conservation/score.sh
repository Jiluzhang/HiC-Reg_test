## phastCons
wget -c http://hgdownload.soe.ucsc.edu/goldenPath/mm10/phastCons60way/mm10.60way.phastCons.bw
computeMatrix reference-point --referencePoint center -p 40 -S mm10.60way.phastCons.bw \
              -R RREs.bed non_IREs_random_2000.bed -o phastCons.gz -a 500 -b 500 -bs 5
plotProfile -m phastCons.gz --yMin 0 --yMax 0.3 --dpi 600 -out phastCons.pdf

## phyloP60way
wget -c http://hgdownload.soe.ucsc.edu/goldenPath/mm10/phyloP60way/mm10.60way.phyloP60way.bw
computeMatrix reference-point --referencePoint center -p 40 -S mm10.60way.phyloP60way.bw \
              -R RREs.bed non_IREs_random_2000.bed -o phyloP60way.gz -a 500 -b 500 -bs 5
plotProfile -m phyloP60way.gz --yMin 0 --yMax 0.3 --dpi 600 -out phyloP60way.pdf
