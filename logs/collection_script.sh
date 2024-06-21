
#!/bin/bash

# Check if namespace argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

namespace=$1

# Clear the existing pods.log file if it exists
rm -f logs/pods.log

# Get the list of pods in the specified namespace
pods=$(kubectl get pods -n "$namespace" -o jsonpath='{.items[*].metadata.name}')

# Iterate through each pod and collect logs
for pod in $pods; do
  echo "Logs for pod: $pod" >> logs/pods.log
  kubectl logs -n "$namespace" "$pod" >> logs/pods.log
  echo "-----------------------------------" >> logs/pods.log
done

echo "Logs collected and saved to logs/pods.log"
