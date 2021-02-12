#!/usr/bin/env bash

searchGroupName=Corp_DataScience_SalesAnalytics
listApps=$(aws servicecatalog-appregistry list-applications --query 'applications[*].name' --output text --region us-east-1)

for app in ${listApps[*]}
  do
    attrGroup=$(aws servicecatalog-appregistry list-associated-attribute-groups --application $app --max-results 1 --query 'attributeGroups[0]' --output text --region us-east-1)
    groupName=$(aws servicecatalog-appregistry get-attribute-group --attribute-group $attrGroup --query 'name' --output text --region us-east-1)
    if [ $groupName = $searchGroupName ]; then printf "$app\n"; fi
  done