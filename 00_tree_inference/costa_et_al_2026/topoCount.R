library(ape)
library(tbea)

set.seed(2001)

trees <- NULL
for (i in 1:4) {
	tree.set <- read.nexus(paste("costa_2026_anterior_portion.nex.run", i, ".t", sep=""))

	tree.len <- length(tree.set)
	burn.in <- as.integer(0.25 * tree.len) + 1
	tree.sample <- sample(tree.set[burn.in:tree.len], 5000)

	if (!is.null(trees)) {
		trees <- c(trees, tree.sample)
	} else {
		trees <- tree.sample
	}
}

tpf <- topoFreq(trees, output="trees")
decreasing.idx <- order(tpf$fabs, decreasing=TRUE)

trees.percentile90 <- sum(cumsum(tpf$fabs[decreasing.idx]) / sum(tpf$fabs) < 0.9)
print(paste(trees.percentile90, "comprise 90% of the tree distribution"))
write.nexus(trees[decreasing.idx[trees.percentile90]], file="percentile_90.nex")

trees.percentile95 <- sum(cumsum(tpf$fabs[decreasing.idx]) / sum(tpf$fabs) < 0.95)
print(paste(trees.percentile95, "comprise 95% of the tree distribution"))
write.nexus(trees[decreasing.idx[trees.percentile95]], file="percentile_95.nex")

top10.trees <- trees[decreasing.idx[1:10]]
top10.freq <- sum(tpf$frel[decreasing.idx[1:10]])
print(paste("Top 10 trees comprise", top10.freq, "of phylogenetic trees", sep=" "))
write.nexus(top10.trees, file="top10.nex")

svg("top10.svg")
M <- matrix(rep(1:12), nrow=4, ncol=3, byrow=T)
M[4,] <- c(0,10,0)
layout(M)
par(oma=c(0, 0, 0, 0), mai=c(0.5, 0.2, 0.5, 0.2))
sumtrees <- summaryBrlen(tpf$trees, method="median")
for (i in 1:10) {
	plot(
		sumtrees[[decreasing.idx[i]]],
		type="unrooted",
		show.node.label=FALSE,
		cex=0.4,
		main=tpf$frel[decreasing.idx[i]], digits=2,
	)
}
