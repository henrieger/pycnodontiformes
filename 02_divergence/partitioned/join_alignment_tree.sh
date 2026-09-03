#!/usr/bin/env bash

cat ../../00_tree_inference/partitioned/costa_2026_partitioned.nex ../../01_mcctree/partitioned/rooted_mcc.nex |
  dos2unix |
  tr '\n' '\000' |
  sed 's/#NEXUS//2' |
  tr '\000' '\n' |
  sed 's/\[R-package APE.*\]//' |
  sed 's/\* UNTITLED/tree1/g' >alignment_and_tree.nex
