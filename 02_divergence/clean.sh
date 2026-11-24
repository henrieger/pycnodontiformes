#!/usr/bin/env bash

echo "You are about to remove all files generated from scripts."
echo -n "Do you want to proceed? [y/n]: "
read confirmation

if ! [[ $confirmation == "y" ]]; then
  echo "Aborting..."
  exit 1
fi

rm -vf \
  {combined,partitioned}/{prior,posterior}/{*.nex.*,*.log,*.svg,figtree.nex}
