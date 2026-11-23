#!/usr/bin/env bash

cat \
  <(sed -n -e '1,/END;/p' ../../00_tree_inference/partitioned/costa_2026_partitioned.nex) \
  <(echo -n -e '\n\n') \
  <(sed -n -e '/BEGIN TREES/,$p' ../../01_mcctree/partitioned/rooted_mcc.nex) |
  dos2unix |
  sed 's/\* UNTITLED/tree1/g' >alignment_and_tree.nex
