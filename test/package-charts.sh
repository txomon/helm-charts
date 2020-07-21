#!/bin/bash

chartsDir="charts/"
repoDir="repo/"

for d in $(find $chartsDir -mindepth 1 -maxdepth 1 -type d); do
  echo "Processing $d"
  helm package -u -d $repoDir "$d"
done

helm repo index $repoDir
