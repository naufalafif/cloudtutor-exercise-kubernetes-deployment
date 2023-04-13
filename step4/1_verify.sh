#!/bin/bash

DEPLOYMENT_NAME="whoami-deployment"
NAMESPACE="default" # Ganti dengan namespace yang sesuai jika diperlukan
EXPECTED_IMAGE="containous/whoami"
EXPECTED_PORT=80
EXPECTED_REPLICAS=4

deployment_data=$(kubectl get deployment $DEPLOYMENT_NAME -n $NAMESPACE -o json 2> /dev/null)

if [ -z "$deployment_data" ]; then
  echo "Deployment $DEPLOYMENT_NAME tidak ditemukan"
  exit 1
fi

actual_image=$(echo $deployment_data | jq -r '.spec.template.spec.containers[0].image')
actual_port=$(echo $deployment_data | jq -r '.spec.template.spec.containers[0].ports[0].containerPort')
actual_replicas=$(echo $deployment_data | jq -r '.spec.replicas')

if [ "$actual_image" == "$EXPECTED_IMAGE" ] && [ "$actual_port" -eq "$EXPECTED_PORT" ] && [ "$actual_replicas" -eq "$EXPECTED_REPLICAS" ]; then
  echo "OK"
else
  echo "Deployment $DEPLOYMENT_NAME memiliki konfigurasi yang salah"
fi