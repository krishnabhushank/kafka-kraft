#!/bin/bash

# Print environment variables
printenv

# Extract node ID from hostname
NODE_ID=${HOSTNAME:6}

# Define listeners and advertised listeners
LISTENERS="PLAINTEXT://:9092,CONTROLLER://:9093"
ADVERTISED_LISTENERS="PLAINTEXT://kafka-$NODE_ID.$SERVICE.$NAMESPACE.svc.cluster.local:9092"

# Construct controller quorum voters list
CONTROLLER_QUORUM_VOTERS=""
for i in $(seq 0 $REPLICAS); do
    if [[ $i != $REPLICAS ]]; then
        CONTROLLER_QUORUM_VOTERS="$CONTROLLER_QUORUM_VOTERS$i@kafka-$i.$SERVICE.$NAMESPACE.svc.cluster.local:9093,"
    else
        CONTROLLER_QUORUM_VOTERS=${CONTROLLER_QUORUM_VOTERS::-1}
    fi
done

# Create directory for Kafka data
mkdir -p $SHARE_DIR/$NODE_ID

# Generate or read cluster ID
if [[ ! -f "$SHARE_DIR/cluster_id" && "$NODE_ID" = "0" ]]; then
    CLUSTER_ID=$(kafka-storage.sh random-uuid)
    echo $CLUSTER_ID > $SHARE_DIR/cluster_id
else
    CLUSTER_ID=$(cat $SHARE_DIR/cluster_id)
fi

# Update server.properties
sed -e "s+^node.id=.*+node.id=$NODE_ID+" \
    -e "s+^controller.quorum.voters=.*+controller.quorum.voters=$CONTROLLER_QUORUM_VOTERS+" \
    -e "s+^listeners=.*+listeners=$LISTENERS+" \
    -e "s+^advertised.listeners=.*+advertised.listeners=$ADVERTISED_LISTENERS+" \
    -e "s+^log.dirs=.*+log.dirs=$SHARE_DIR/$NODE_ID+" \
    /app/kafka/config/kraft/server.properties > /tmp/server.properties.updated

mv /tmp/server.properties.updated /app/kafka/config/kraft/server.properties

# Format Kafka storage
kafka-storage.sh format -t $CLUSTER_ID -c /app/kafka/config/kraft/server.properties

# Start Kafka server
exec kafka-server-start.sh /app/kafka/config/kraft/server.properties
