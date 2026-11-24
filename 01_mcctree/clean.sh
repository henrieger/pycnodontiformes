#!/usr/bin/env bash

echo "You are about to remove all files generated from scripts."
echo -n "Do you want to proceed? [y/n]: "
read confirmation

if ! [[ $confirmation == "y" ]]; then
  echo "Aborting..."
  exit 1
fi

rm -vf \
  {combined,partitioned}/{combined_trees.newick,maxcredtree.tre,rooted_mcc.nex}
