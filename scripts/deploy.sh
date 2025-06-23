#!/bin/bash

echo "🔄 Converting OpenAPI to JSON..."
yq eval -o=json openapi/devport-api.yaml > openapi/devport-api.json

echo "🚀 Running Terraform"
cd terraform
terraform init
terraform apply