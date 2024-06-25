# kafka-kraft

To convert the provided Docker Compose YAML to Kubernetes Deployment YAML, we'll create individual Kubernetes `Deployment` and `Service` resources for each Kafka broker. Here's how the conversion would look:

### kafka-1 Deployment and Service

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kafka-1
  labels:
    app: kafka
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kafka
      broker: kafka-1
  template:
    metadata:
      labels:
        app: kafka
        broker: kafka-1
    spec:
      containers:
        - name: kafka
          image: ${IMAGE}
          ports:
            - containerPort: 19092
            - containerPort: 9093
            - containerPort: 9092
          env:
            - name: KAFKA_NODE_ID
              value: "1"
            - name: KAFKA_PROCESS_ROLES
              value: "broker,controller"
            - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
              value: "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            - name: KAFKA_CONTROLLER_QUORUM_VOTERS
              value: "1@kafka-1:9093,2@kafka-2:9093,3@kafka-3:9093"
            - name: KAFKA_LISTENERS
              value: "PLAINTEXT://:19092,CONTROLLER://:9093,PLAINTEXT_HOST://:9092"
            - name: KAFKA_INTER_BROKER_LISTENER_NAME
              value: "PLAINTEXT"
            - name: KAFKA_ADVERTISED_LISTENERS
              value: "PLAINTEXT://kafka-1:19092,PLAINTEXT_HOST://localhost:29092"
            - name: KAFKA_CONTROLLER_LISTENER_NAMES
              value: "CONTROLLER"
            - name: CLUSTER_ID
              value: "4L6g3nShT-eMCtK--X86sw"
            - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS
              value: "0"
            - name: KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
              value: "1"
            - name: KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_LOG_DIRS
              value: "/tmp/kraft-combined-logs"

---
apiVersion: v1
kind: Service
metadata:
  name: kafka-1
spec:
  selector:
    app: kafka
    broker: kafka-1
  ports:
    - name: kafka-plain
      protocol: TCP
      port: 29092
      targetPort: 9092
```

### kafka-2 Deployment and Service

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kafka-2
  labels:
    app: kafka
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kafka
      broker: kafka-2
  template:
    metadata:
      labels:
        app: kafka
        broker: kafka-2
    spec:
      containers:
        - name: kafka
          image: ${IMAGE}
          ports:
            - containerPort: 19092
            - containerPort: 9093
            - containerPort: 9092
          env:
            - name: KAFKA_NODE_ID
              value: "2"
            - name: KAFKA_PROCESS_ROLES
              value: "broker,controller"
            - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
              value: "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            - name: KAFKA_CONTROLLER_QUORUM_VOTERS
              value: "1@kafka-1:9093,2@kafka-2:9093,3@kafka-3:9093"
            - name: KAFKA_LISTENERS
              value: "PLAINTEXT://:19092,CONTROLLER://:9093,PLAINTEXT_HOST://:9092"
            - name: KAFKA_INTER_BROKER_LISTENER_NAME
              value: "PLAINTEXT"
            - name: KAFKA_ADVERTISED_LISTENERS
              value: "PLAINTEXT://kafka-2:19092,PLAINTEXT_HOST://localhost:39092"
            - name: KAFKA_CONTROLLER_LISTENER_NAMES
              value: "CONTROLLER"
            - name: CLUSTER_ID
              value: "4L6g3nShT-eMCtK--X86sw"
            - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS
              value: "0"
            - name: KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
              value: "1"
            - name: KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_LOG_DIRS
              value: "/tmp/kraft-combined-logs"

---
apiVersion: v1
kind: Service
metadata:
  name: kafka-2
spec:
  selector:
    app: kafka
    broker: kafka-2
  ports:
    - name: kafka-plain
      protocol: TCP
      port: 39092
      targetPort: 9092
```

### kafka-3 Deployment and Service

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kafka-3
  labels:
    app: kafka
spec:
  replicas: 1
  selector:
    matchLabels:
      app: kafka
      broker: kafka-3
  template:
    metadata:
      labels:
        app: kafka
        broker: kafka-3
    spec:
      containers:
        - name: kafka
          image: ${IMAGE}
          ports:
            - containerPort: 19092
            - containerPort: 9093
            - containerPort: 9092
          env:
            - name: KAFKA_NODE_ID
              value: "3"
            - name: KAFKA_PROCESS_ROLES
              value: "broker,controller"
            - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
              value: "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            - name: KAFKA_CONTROLLER_QUORUM_VOTERS
              value: "1@kafka-1:9093,2@kafka-2:9093,3@kafka-3:9093"
            - name: KAFKA_LISTENERS
              value: "PLAINTEXT://:19092,CONTROLLER://:9093,PLAINTEXT_HOST://:9092"
            - name: KAFKA_INTER_BROKER_LISTENER_NAME
              value: "PLAINTEXT"
            - name: KAFKA_ADVERTISED_LISTENERS
              value: "PLAINTEXT://kafka-3:19092,PLAINTEXT_HOST://localhost:49092"
            - name: KAFKA_CONTROLLER_LISTENER_NAMES
              value: "CONTROLLER"
            - name: CLUSTER_ID
              value: "4L6g3nShT-eMCtK--X86sw"
            - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS
              value: "0"
            - name: KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
              value: "1"
            - name: KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_LOG_DIRS
              value: "/tmp/kraft-combined-logs"

---
apiVersion: v1
kind: Service
metadata:
  name: kafka-3
spec:
  selector:
    app: kafka
    broker: kafka-3
  ports:
    - name: kafka-plain
      protocol: TCP
      port: 49092
      targetPort: 9092
```

---
## As a `Stateful Set`

Converting the above Kubernetes `Deployment` configurations to a `StatefulSet` configuration makes sense for Kafka, as it benefits from stable network identities and persistent storage. Here’s how you can convert it to use a `StatefulSet`:

### Kafka StatefulSet and Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: kafka-headless
  labels:
    app: kafka
spec:
  ports:
    - port: 9092
      name: client
    - port: 9093
      name: controller
  clusterIP: None
  selector:
    app: kafka
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: kafka
spec:
  serviceName: "kafka-headless"
  replicas: 3
  selector:
    matchLabels:
      app: kafka
  template:
    metadata:
      labels:
        app: kafka
    spec:
      containers:
        - name: kafka
          image: ${IMAGE}
          ports:
            - containerPort: 9092
              name: client
            - containerPort: 9093
              name: controller
          env:
            - name: KAFKA_NODE_ID
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: KAFKA_PROCESS_ROLES
              value: "broker,controller"
            - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
              value: "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            - name: KAFKA_CONTROLLER_QUORUM_VOTERS
              value: "1@kafka-0.kafka-headless:9093,2@kafka-1.kafka-headless:9093,3@kafka-2.kafka-headless:9093"
            - name: KAFKA_LISTENERS
              value: "PLAINTEXT://:19092,CONTROLLER://:9093,PLAINTEXT_HOST://:9092"
            - name: KAFKA_INTER_BROKER_LISTENER_NAME
              value: "PLAINTEXT"
            - name: KAFKA_ADVERTISED_LISTENERS
              value: "PLAINTEXT://$(KAFKA_NODE_ID).kafka-headless:19092,PLAINTEXT_HOST://localhost:$(($(KAFKA_NODE_ID) + 1) * 10000 + 9092)"
            - name: KAFKA_CONTROLLER_LISTENER_NAMES
              value: "CONTROLLER"
            - name: CLUSTER_ID
              value: "4L6g3nShT-eMCtK--X86sw"
            - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS
              value: "0"
            - name: KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
              value: "1"
            - name: KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_LOG_DIRS
              value: "/tmp/kraft-combined-logs"
          volumeMounts:
            - name: kafka-storage
              mountPath: /tmp/kraft-combined-logs
  volumeClaimTemplates:
    - metadata:
        name: kafka-storage
      spec:
        accessModes: [ "ReadWriteOnce" ]
        resources:
          requests:
            storage: 1Gi
```

### Explanation:

1. **Headless Service**: A headless service named `kafka-headless` is created to manage the network identities of the Kafka pods without a ClusterIP.
2. **StatefulSet**: A `StatefulSet` named `kafka` is defined with 3 replicas.
3. **Environment Variables**: The `KAFKA_NODE_ID` is dynamically assigned based on the pod name using a `fieldRef`. This allows each pod to have a unique ID.
4. **Volume Claim Templates**: A `PersistentVolumeClaim` template is specified to provide persistent storage for each Kafka broker.

### Ports Mapping and Advertised Listeners:
- The ports are configured directly on the Kafka container.
- The `KAFKA_ADVERTISED_LISTENERS` environment variable is adjusted to use the pod name and dynamically calculate the host port.

Make sure to replace `${IMAGE}` with the actual Kafka image name you intend to use. Additionally, adjust the storage size and other configurations based on your specific requirements and Kubernetes cluster setup.
In these configurations:
- Each Kafka broker is deployed as a separate `Deployment`.
- Each broker has a corresponding `Service` to expose the Kafka ports.
- Environment variables are set to match those from the Docker Compose file.
- Port mappings are adjusted to use Kubernetes service ports.

Make sure to replace `${IMAGE}` with the actual Kafka image you intend to use. Additionally, you might need to adjust other configurations based on your specific requirements and Kubernetes cluster setup.

---
## With Mount Volumes
To incorporate the volumes `/etc/kafka/secrets`, `/var/lib/kafka/data`, and `/mnt/shared/config` into the Kubernetes StatefulSet, you'll need to add corresponding volume mounts and PersistentVolumeClaims for each. Here is the updated configuration:

### Kafka StatefulSet and Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: kafka-headless
  labels:
    app: kafka
spec:
  ports:
    - port: 9092
      name: client
    - port: 9093
      name: controller
  clusterIP: None
  selector:
    app: kafka
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: kafka
spec:
  serviceName: "kafka-headless"
  replicas: 3
  selector:
    matchLabels:
      app: kafka
  template:
    metadata:
      labels:
        app: kafka
    spec:
      containers:
        - name: kafka
          image: ${IMAGE}
          ports:
            - containerPort: 9092
              name: client
            - containerPort: 9093
              name: controller
          env:
            - name: KAFKA_NODE_ID
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: KAFKA_PROCESS_ROLES
              value: "broker,controller"
            - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
              value: "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT"
            - name: KAFKA_CONTROLLER_QUORUM_VOTERS
              value: "1@kafka-0.kafka-headless:9093,2@kafka-1.kafka-headless:9093,3@kafka-2.kafka-headless:9093"
            - name: KAFKA_LISTENERS
              value: "PLAINTEXT://:19092,CONTROLLER://:9093,PLAINTEXT_HOST://:9092"
            - name: KAFKA_INTER_BROKER_LISTENER_NAME
              value: "PLAINTEXT"
            - name: KAFKA_ADVERTISED_LISTENERS
              value: "PLAINTEXT://$(KAFKA_NODE_ID).kafka-headless:19092,PLAINTEXT_HOST://localhost:$(($(KAFKA_NODE_ID) + 1) * 10000 + 9092)"
            - name: KAFKA_CONTROLLER_LISTENER_NAMES
              value: "CONTROLLER"
            - name: CLUSTER_ID
              value: "4L6g3nShT-eMCtK--X86sw"
            - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS
              value: "0"
            - name: KAFKA_TRANSACTION_STATE_LOG_MIN_ISR
              value: "1"
            - name: KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR
              value: "1"
            - name: KAFKA_LOG_DIRS
              value: "/var/lib/kafka/data"
          volumeMounts:
            - name: kafka-storage
              mountPath: /var/lib/kafka/data
            - name: kafka-secrets
              mountPath: /etc/kafka/secrets
            - name: kafka-config
              mountPath: /mnt/shared/config
  volumeClaimTemplates:
    - metadata:
        name: kafka-storage
      spec:
        accessModes: [ "ReadWriteOnce" ]
        resources:
          requests:
            storage: 10Gi
    - metadata:
        name: kafka-secrets
      spec:
        accessModes: [ "ReadWriteOnce" ]
        resources:
          requests:
            storage: 1Gi
    - metadata:
        name: kafka-config
      spec:
        accessModes: [ "ReadWriteOnce" ]
        resources:
          requests:
            storage: 1Gi
```

### Explanation:

1. **Headless Service**: The same headless service named `kafka-headless` is used to manage the network identities of the Kafka pods.
2. **StatefulSet**: The `StatefulSet` named `kafka` is defined with 3 replicas.
3. **Environment Variables**: The `KAFKA_NODE_ID` is dynamically assigned based on the pod name using a `fieldRef`.
4. **Volume Mounts**: Three volume mounts are added for `/var/lib/kafka/data`, `/etc/kafka/secrets`, and `/mnt/shared/config`.
5. **PersistentVolumeClaims**: Three `PersistentVolumeClaim` templates are specified for persistent storage for each of the volumes.

Make sure to replace `${IMAGE}` with the actual Kafka image name you intend to use. Additionally, adjust the storage sizes and other configurations based on your specific requirements and Kubernetes cluster setup.
