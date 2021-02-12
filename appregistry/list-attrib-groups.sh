#!/usr/bin/env bash

listApps=$(aws servicecatalog-appregistry list-applications --query 'applications[*].name' --output text --region us-east-1)

for app in ${listApps[*]}
  do
    attrGroup=$(aws servicecatalog-appregistry list-associated-attribute-groups --application $app --max-results 1 --query 'attributeGroups[0]' --output text --region us-east-1)
    printf "Attributes for $app\n"
    aws servicecatalog-appregistry get-attribute-group --attribute-group $attrGroup --query 'attributes' --region us-east-1
  done