#!/usr/bin/env bash

# combine the tree samples
pxlog -t ../../00_tree_inference/combined/*.run*.t -b 7501 | pxt2new -o combined_trees.newick
rm phyx.logfile

treeannotator -burnin 0 -file combined_trees.newick maxcredtree.tre
