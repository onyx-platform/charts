#!/bin/bash
echo "Checking charts directories for changed files."
CHARTS=$(find . -path '*/Chart.yaml' | tr '\n' ' ' | sed -E 's:\./|/Chart\.yaml::g')

for chart in $CHARTS; do
    if [ -z "$(git status $chart --untracked-files=no --porcelain)" ]; then
        :
    else
        if [ -z "$(git status $chart/Chart.yaml --untracked-files=no --porcelain)" ]; then
            echo "Chart changed but version not bumped: $chart, bumping dependency and staging.";
            helm bump "$chart" -z
            git stage "$chart"
        else
            echo "Chart changed: $chart, but Chart.yaml already modified, doing nothing.";
        fi

    fi
done
