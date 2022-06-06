########## P1 ##########
## IREs
sham <- read.table('P1_1.5Sham_IREs.txt')[, c(4, 8)]
#chr1	3616	3636	E_1	chr1	3616	3617	4.86
#chr1	3616	3636	E_1	chr1	3616	3618	4.22
#chr1	3616	3636	E_1	chr1	3616	3619	3.99
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P1_1.5MI_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

ire <- mi_agg$val - sham_agg$val

## non_IREs
sham <- read.table('P1_1.5Sham_non_IREs.txt')[, c(4, 8)]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P1_1.5MI_non_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

non_ire <- mi_agg$val - sham_agg$val

## concat
dat <- rbind(data.frame(val = ire, idx = 'IREs'),
             data.frame(val = non_ire, idx = 'Non_IREs'))

## plot box
pdf('P1_1.5Sham_MI_obs_pair_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(-0.2, 0.3), las = 1)
dev.off()
wilcox.test(ire, non_ire)$p.value  # 2.884782e-149


########## P8 ##########
## IREs
sham <- read.table('P8_1.5Sham_IREs.txt')[, c(4, 8)]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P8_1.5MI_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

ire <- mi_agg$val - sham_agg$val

## non_IREs
sham <- read.table('P8_1.5Sham_non_IREs.txt')[, c(4, 8)]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P8_1.5MI_non_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

non_ire <- mi_agg$val - sham_agg$val

## concat
dat <- rbind(data.frame(val = ire, idx = 'IREs'),
             data.frame(val = non_ire, idx = 'Non_IREs'))

## plot box
pdf('P8_1.5Sham_MI_obs_pair_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(-0.2, 0.3), las = 1)
dev.off()
wilcox.test(ire, non_ire)$p.value  # 1.389625e-38
