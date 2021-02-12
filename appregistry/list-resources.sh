#!/usr/bin/env bash

listApps=$(aws servicecatalog-appregistry list-applications --query 'applications[*].name' --output text --region us-east-1)

for app in ${listApps[*]}
  do
    resource=$(aws servicecatalog-appregistry list-associated-resources --application $app --max-results 1 --output text --region us-east-1)
    printf "$resource\n"
  done