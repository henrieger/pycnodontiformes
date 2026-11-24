library(ape)

tree <- read.nexus("maxcredtree.tre")
tree$tip.label

rooted.tree <- root(tree, outgroup=26, resolve.root=TRUE)
rooted.tree$edge
rooted.tree$edge.length

rooted.tree$edge.length[1] <- rooted.tree$edge.length[82]/2
rooted.tree$edge.length[82] <- rooted.tree$edge.length[82]/2
rooted.tree$edge.length

write.nexus(rooted.tree, file="rooted_mcc.nex")
