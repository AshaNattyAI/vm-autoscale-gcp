#!/bin/bash
# Resource Monitor - Triggers GCP scale-out when CPU or MEM exceeds threshold
# Assignment 3: Local VM Auto-Scale to GCP
# Author: Gururaj Nayak

THRESHOLD=75
LOG="$HOME/auto-scale/monitor.log"
TRIGGER_SCRIPT="$HOME/auto-scale/trigger_gcp.sh"

mkdir -p "$HOME/auto-scale"
echo "$(date) - Monitor started. Threshold: $THRESHOLD%" | tee -a $LOG

while true; do
  CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
  MEM=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
  
  echo "$(date) | CPU: ${CPU}% | MEM: ${MEM}%" | tee -a $LOG

  if (( CPU > THRESHOLD || MEM > THRESHOLD )); then
    echo "$(date) - THRESHOLD EXCEEDED! CPU:${CPU}% MEM:${MEM}% - Triggering GCP..." | tee -a $LOG
    bash $TRIGGER_SCRIPT | tee -a $LOG
    echo "$(date) - Scale-out complete." | tee -a $LOG
    break
  fi

  sleep 10
done
