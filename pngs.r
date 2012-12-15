#!/usr/bin/env Rscript

library(ggplot2)
library(scales)

outputWidth=10
outputHeight=6

files <- Sys.glob("*.tsv")

results <- lapply(files, function(.file){
  .in <- read.table(.file, sep="\t", header=T)
  .in$time = ISOdatetime(1970,1,1,0,0,0) + .in$time / 1000
  .in
})

results <- do.call(rbind, results)

# Jitter Graph
p <- ggplot(results, aes(benchmark, duration, color=benchmark))
p <- p + scale_y_continuous(label=comma_format())
p <- p + facet_wrap(~ results, scales = "free")
p + geom_jitter()

ggsave(filename="jitter.png", width=outputWidth, height=outputHeight)

# Line graph
p <- ggplot(results, aes(number, duration, color=benchmark))
p <- p + scale_y_continuous(label=comma_format())
p <- p + facet_wrap(~ results, scales = "free", ncol=1)
p + geom_line()

ggsave(filename="line.png", width=outputWidth, height=outputHeight)

# Heap Used
p <- ggplot(results, aes(number, heapUsed / 1024 / 1024, color=benchmark))
p <- p + labs(y = "Heap Used (MB)")
p <- p + facet_wrap(~ results, scales = "free", ncol=1)
p + geom_line()

ggsave(filename="heap-used.png", width=outputWidth, height=outputHeight)

# Heap Total
p <- ggplot(results, aes(number, heapTotal / 1024 / 1024, color=benchmark))
p <- p + labs(y = "Heap Total (MB)")
p <- p + facet_wrap(~ results, scales = "free", ncol=1)
p + geom_line()

ggsave(filename="heap-total.png", width=outputWidth, height=outputHeight)

