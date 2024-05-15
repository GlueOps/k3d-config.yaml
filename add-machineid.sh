#!/bin/bash

# k3d nodes don't have machine id and it must be added
containers=$(docker ps --filter "name=k3d" --format "{{.Names}}")

for container in $containers; do
    echo "Setting /etc/machine-id for $container..."
    unique_id=$(openssl rand -hex 16)
    docker exec $container sh -c "echo $unique_id > /etc/machine-id"
done

echo "Done."
