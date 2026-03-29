# VM Auto-Scale to GCP

Assignment 3 - Virtual Cloud Computing | M.Tech | IIT Jodhpur

## Overview
Monitors local VM resource usage and auto-scales to Google Cloud Platform
when CPU or memory exceeds 75%.

## Architecture
Local VM (VirtualBox) → monitor.sh → threshold check → trigger_gcp.sh → GCP Compute Engine

## Setup

### Prerequisites
- Oracle VirtualBox with Ubuntu 24.04 LTS
- Google Cloud SDK (gcloud CLI)
- GCP project with Compute Engine API enabled

### Run
```bash
# 1. Authenticate with GCP
gcloud auth activate-service-account --key-file=/path/to/key.json
gcloud config set project csl7510-autoscale

# 2. Start monitor
bash monitor.sh &

# 3. Simulate high CPU
sudo apt install stress -y
stress --cpu 4 --timeout 120
```

## Files
| File | Description |
|------|-------------|
| `monitor.sh` | Monitors CPU/MEM every 10s, triggers scale-out at >75% |
| `trigger_gcp.sh` | Creates GCP Compute Engine VM with Apache2 |

## Cloud Platform
- **Provider:** Google Cloud Platform  
- **Project:** csl7510-autoscale  
- **Zone:** us-central1-a  
- **Instance type:** e2-medium
