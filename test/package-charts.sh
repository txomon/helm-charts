#!/bin/bash
set -xev

repoDir="repo/"
hasUpdates=false
echo "Checking for updates in charts"
for d in $( docker run --rm -v "$(pwd)":/repo -w /repo/ quay.io/helmpack/chart-testing ct list-changed); do
  echo "Repackaging chart $d"
  helm package -u -d $repoDir "$d"
  hasUpdates=true
done

if [[ "true" = "$hasUpdates" ]]; then
  echo "Rebuilding index"
  helm repo index $repoDir
else
  echo "No updates to the index required"
fi
