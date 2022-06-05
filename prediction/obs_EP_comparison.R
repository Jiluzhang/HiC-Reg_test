########## IRE-gene for P1 ##########
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

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

pdf('P1_1.5Sham_MI_IREs_genes_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(2, 6), las = 1)  # bimodal distribution
dev.off()
wilcox.test(sham_agg$val, mi_agg$val)$p.value  # 0.03460881 



########## non_IRE-gene for P1 ##########
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

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

pdf('P1_1.5Sham_MI_non_IREs_genes_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(2, 6), las = 1)
dev.off()
wilcox.test(sham_agg$val, mi_agg$val)$p.value  # 0.5515136



########## IRE-gene for P8 ##########
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

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

pdf('P8_1.5Sham_MI_IREs_genes_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(2, 6), las = 1)
dev.off()
wilcox.test(sham_agg$val, mi_agg$val)$p.value  # 0.4722958


########## non_IRE-gene for P8 ##########
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

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

pdf('P8_1.5Sham_MI_non_IREs_genes_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(2, 6), las = 1)
dev.off()
wilcox.test(sham_agg$val, mi_agg$val)$p.value  # 0.3288645
