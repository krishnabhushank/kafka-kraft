FROM openjdk:17-bullseye

# Create a group and user without specifying UID and GID
RUN groupadd -r user && useradd -r -g user user

# Set the working directory to /app
WORKDIR /app

# Copy entrypoint.sh before changing the user
COPY ./entrypoint.sh /app/

# Set permissions to ensure the non-root user can execute the entrypoint
RUN chmod +x /app/entrypoint.sh

# Set the ownership of /app to ensure it is writable by any user
RUN chown -R user:user /app

# Set permissions to ensure /app is writable by any user (UID 1000)
RUN chmod -R 777 /app

# Switch to the non-root user
USER user

ENV KAFKA_VERSION=3.7.0
ENV SCALA_VERSION=2.12
ENV KAFKA_HOME=/app/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

LABEL name="kafka" version=${KAFKA_VERSION}

RUN wget --no-check-certificate -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /app \
 && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && ln -s /app/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}

ENTRYPOINT ["/app/entrypoint.sh"]
