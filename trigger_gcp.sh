#!/bin/bash
# GCP Auto-Scale Trigger Script
# Provisions a new Compute Engine VM when local resources are exceeded
# Author: Asha N

PROJECT_ID="csl7510-autoscale"
ZONE="us-central1-a"
INSTANCE_NAME="auto-scaled-vm"
MACHINE_TYPE="e2-medium"
IMAGE_FAMILY="ubuntu-2204-lts"
IMAGE_PROJECT="ubuntu-os-cloud"

echo "$(date) - Launching GCP instance: $INSTANCE_NAME"

gcloud compute instances create $INSTANCE_NAME \
  --project=$PROJECT_ID \
  --zone=$ZONE \
  --machine-type=$MACHINE_TYPE \
  --image-family=$IMAGE_FAMILY \
  --image-project=$IMAGE_PROJECT \
  --tags=http-server \
  --metadata=startup-script='#!/bin/bash
    apt update -y
    apt install -y apache2
    systemctl enable apache2
    systemctl start apache2
    echo "<h1>Auto-Scaled GCP VM - Assignment 3</h1>" > /var/www/html/index.html'

echo "$(date) - GCP VM launched successfully in zone: $ZONE"
echo "$(date) - Instance: $INSTANCE_NAME | Type: $MACHINE_TYPE"
