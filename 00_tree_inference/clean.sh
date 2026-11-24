#!/usr/bin/env bash

echo "You are about to remove all files generated from scripts."
echo -n "Do you want to proceed? [y/n]: "
read confirmation

if ! [[ $confirmation == "y" ]]; then
  echo "Aborting..."
  exit 1
fi

for scheme in {combined,partitioned}; do
  rm -vf ${scheme}/costa_et_al_2026.log
  rm -vf ${scheme}/costa_2026_${scheme}.nex.*
  rm -vf ${scheme}/figtree.nex{,.svg,png}
done
