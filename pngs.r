#!/usr/bin/env Rscript

library(ggplot2)
library(scales)

outputWidth=10
outputHeight=6

files <- Sys.glob("*.tsv")

results <- lapply(files, function(.file){
  .in <- read.table(.file, sep="\t", header=T)
  .in$time = ISOdatetime(1970,1,1,0,0,0) + .in$time / 1000
  #.in$mbit = (.in$bytes / (.in$duration / 1000) * 8) / 1024 / 1024
  .in
})

results <- do.call(rbind, results)

# Bar
#a <- data.frame(benchmark = c('mysql2'), mbit = c(median(subset(results, benchmark == "mysql2")$mbit)))
#b <- data.frame(benchmark = c('new-parser'), mbit = c(median(subset(results, benchmark == "new-parser")$mbit)))

#p <- ggplot(rbind(a,b), aes(benchmark, mbit, fill=benchmark))
#p <- p + scale_y_continuous(label=comma_format())
#p + geom_bar()

#ggsave(filename="pdfs/bar.pdf", width=outputWidth, height=outputHeight)

# Jitter Graph
p <- ggplot(results, aes(benchmark, duration, color=benchmark))
p <- p + scale_y_log10(label=comma_format())
p + geom_jitter()

ggsave(filename="jitter.png", width=outputWidth, height=outputHeight)

# Line graph
p <- ggplot(results, aes(number, duration, color=benchmark))
p <- p + scale_y_continuous(label=comma_format())
p + geom_line()

ggsave(filename="line.png", width=outputWidth, height=outputHeight)

# Heap Used
p <- ggplot(results, aes(number, heapUsed / 1024 / 1024, color=benchmark))
p <- p + labs(y = "Heap Used (MB)")
p + geom_line()

ggsave(filename="heap-used.png", width=outputWidth, height=outputHeight)

# Heap Total
p <- ggplot(results, aes(number, heapTotal / 1024 / 1024, color=benchmark))
p <- p + labs(y = "Heap Total (MB)")
p + geom_line()

ggsave(filename="heap-total.png", width=outputWidth, height=outputHeight)

