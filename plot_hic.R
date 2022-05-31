########################## testing set (resolution: 10kb) #############################
dat <- read.table('testset_error.txt', skip = 1, col.names = c('idx', 'true', 'pred', 'se', 'dist'), stringsAsFactors = FALSE)

## extract left and right position
library(stringr)
dat$left  <- as.numeric(str_split_fixed(dat$idx, "_", 5)[, 2]) / 10000
dat$right <- as.numeric(str_split_fixed(dat$idx, "_", 5)[, 4]) / 10000

dat <- dat[, c('left', 'right', 'true', 'pred')]

n <- max(dat$right)
hic_true <- matrix(rep(0, n*n), nrow = n)
hic_pred <- hic_true
for (i in 1:nrow(dat)){
  hic_true[dat$left[i], dat$right[i]] <- dat$true[i]
  hic_true[dat$right[i], dat$left[i]] <- dat$true[i]
  hic_pred[dat$left[i], dat$right[i]] <- dat$pred[i]
  hic_pred[dat$right[i], dat$left[i]] <- dat$pred[i]
}

library(pheatmap)
## plot true interactions
png('chr1_true_test.png')
pheatmap(hic_true[500:1000, 500:1000], cluster_row = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, breaks = seq(0, 3, 0.03),
         color = colorRampPalette(c('white', 'red'))(100))
dev.off()

## plot predicted interactions
png('chr1_predict_test.png')
pheatmap(hic_pred[500:1000, 500:1000], cluster_row = FALSE, cluster_cols = FALSE,
         show_rownames = FALSE, breaks = seq(0, 3, 0.03),
         color = colorRampPalette(c('white', 'red'))(100))
dev.off()
