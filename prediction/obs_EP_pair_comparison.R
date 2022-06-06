########## P1 ##########
## IRE-gene for P1
sham <- read.table('P1_1.5Sham_IREs_genes.txt')[, c(1:3, 7)]
#chr1	3626	3627	chr1	3626	3627	4.87
#chr1	3748	3749	chr1	3748	3749	4.87
#chr1	3959	3960	chr1	3959	3960	4.87
sham$idx <- paste0(sham[, 1], '_', sham[, 2], '_', sham[, 3])
sham <- sham[, 5:4]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P1_1.5MI_IREs_genes.txt')[, c(1:3, 7)]
mi$idx <- paste0(mi[, 1], '_', mi[, 2], '_', mi[, 3])
mi <- mi[, 5:4]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

ire <- mi_agg$val - sham_agg$val

## non_IRE-gene for P1
sham <- read.table('P1_1.5Sham_non_IREs_genes.txt')[, c(1:3, 7)]
sham$idx <- paste0(sham[, 1], '_', sham[, 2], '_', sham[, 3])
sham <- sham[, 5:4]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P1_1.5MI_non_IREs_genes.txt')[, c(1:3, 7)]
mi$idx <- paste0(mi[, 1], '_', mi[, 2], '_', mi[, 3])
mi <- mi[, 5:4]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

non_ire <- mi_agg$val - sham_agg$val

## concat
dat <- rbind(data.frame(val = ire, idx = 'IREs'),
             data.frame(val = non_ire, idx = 'Non_IREs'))

## plot box
pdf('P1_1.5Sham_MI_genes_obs_pair_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(-0.3, 0.3), las = 1)
dev.off()
wilcox.test(ire, non_ire)$p.value  # 4.945547e-29


########## P8 ##########
## IRE-gene for P8
sham <- read.table('P8_1.5Sham_IREs_genes.txt')[, c(1:3, 7)]
sham$idx <- paste0(sham[, 1], '_', sham[, 2], '_', sham[, 3])
sham <- sham[, 5:4]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P8_1.5MI_IREs_genes.txt')[, c(1:3, 7)]
mi$idx <- paste0(mi[, 1], '_', mi[, 2], '_', mi[, 3])
mi <- mi[, 5:4]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

ire <- mi_agg$val - sham_agg$val

## non_IRE-gene for P1
sham <- read.table('P8_1.5Sham_non_IREs_genes.txt')[, c(1:3, 7)]
sham$idx <- paste0(sham[, 1], '_', sham[, 2], '_', sham[, 3])
sham <- sham[, 5:4]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P8_1.5MI_non_IREs_genes.txt')[, c(1:3, 7)]
mi$idx <- paste0(mi[, 1], '_', mi[, 2], '_', mi[, 3])
mi <- mi[, 5:4]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

non_ire <- mi_agg$val - sham_agg$val

## concat
dat <- rbind(data.frame(val = ire, idx = 'IREs'),
             data.frame(val = non_ire, idx = 'Non_IREs'))

## plot box
pdf('P8_1.5Sham_MI_genes_obs_pair_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(-0.3, 0.3), las = 1)
dev.off()
wilcox.test(ire, non_ire)$p.value  # 7.195182e-12
