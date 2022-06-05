########## IREs for P1 ##########
sham <- read.table('P1_1.5Sham_IREs.txt')[, c(4, 8)]
#chr1	3616	3636	E_1	chr1	3616	3617	4.86
#chr1	3616	3636	E_1	chr1	3616	3618	4.22
#chr1	3616	3636	E_1	chr1	3616	3619	3.99
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P1_1.5MI_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

## KS test: https://d.cosx.org/d/108167-108167/3
#ks.test(jitter(sham_agg$val), jitter(mi_agg$val))
#library(ggplot2)
#library(ggthemes)
#p <- ggplot(dat, aes(x = val)) + stat_ecdf(aes(color = idx)) + 
#     scale_x_continuous(limits = c(3, 4), breaks = seq(3, 4, 0.2)) + 
#     scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.2)) + theme_few()
#ggsave(p, file = "P1_1.5Sham_MI_IREs_obs_cul.pdf")

pdf('P1_1.5Sham_MI_IREs_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(3, 4), las = 1)
dev.off()
t.test(sham_agg$val, mi_agg$val)$p.value  # 9.052523e-41


######### non_IREs for P1 ##########
sham <- read.table('P1_1.5Sham_non_IREs.txt')[, c(4, 8)]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P1_1.5MI_non_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

#p <- ggplot(dat, aes(x = val)) + stat_ecdf(aes(color = idx)) + 
#     scale_x_continuous(limits = c(3, 4), breaks = seq(3, 4, 0.2)) + 
#     scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.2)) + theme_few()
#ggsave(p, file = "P1_1.5Sham_MI_non_IREs_obs_cul.pdf")

pdf('P1_1.5Sham_MI_non_IREs_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(3, 4), las = 1)
dev.off()
t.test(sham_agg$val, mi_agg$val)$p.value  # 0.6254629


########## IREs for P8 ##########
sham <- read.table('P8_1.5Sham_IREs.txt')[, c(4, 8)]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P8_1.5MI_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

pdf('P8_1.5Sham_MI_IREs_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(3, 4), las = 1)
dev.off()
t.test(sham_agg$val, mi_agg$val)$p.value  # 2.344935e-09


######### non_IREs for P8 ##########
sham <- read.table('P8_1.5Sham_non_IREs.txt')[, c(4, 8)]
colnames(sham) <- c('idx', 'val')
sham_agg <- aggregate(sham['val'], by = list(idx = sham$idx), FUN = mean)

mi <- read.table('P8_1.5MI_non_IREs.txt')[, c(4, 8)]
colnames(mi) <- c('idx', 'val')
mi_agg <- aggregate(mi['val'], by = list(idx = mi$idx), FUN = mean)

dat <- rbind(data.frame(val = sham_agg$val, idx = 'Sham'),
             data.frame(val = mi_agg$val, idx = 'MI'))

pdf('P8_1.5Sham_MI_non_IREs_obs_box.pdf')
boxplot(val ~ idx, dat, outline = FALSE, notch = FALSE, ylim = c(3, 4), las = 1)
dev.off()
t.test(sham_agg$val, mi_agg$val)$p.value  # 0.5130696
