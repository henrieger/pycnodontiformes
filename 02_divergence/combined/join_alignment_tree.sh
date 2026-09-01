#!/usr/bin/env bash

cat ../../00_tree_inference/combined/costa_2026_anterior_portion.nex ../../01_mcctree/combined/rooted_mcc.nex |
  dos2unix |
  tr '\n' '\000' |
  sed 's/#NEXUS//2' |
  tr '\000' '\n' |
  sed 's/\[R-package APE.*\]//' |
  sed 's/\* UNTITLED/tree1/g' >alignment_and_tree.nex
