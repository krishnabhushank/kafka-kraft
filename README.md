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

In these configurations:
- Each Kafka broker is deployed as a separate `Deployment`.
- Each broker has a corresponding `Service` to expose the Kafka ports.
- Environment variables are set to match those from the Docker Compose file.
- Port mappings are adjusted to use Kubernetes service ports.

Make sure to replace `${IMAGE}` with the actual Kafka image you intend to use. Additionally, you might need to adjust other configurations based on your specific requirements and Kubernetes cluster setup.
