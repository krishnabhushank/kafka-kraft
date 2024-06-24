FROM openjdk:17-bullseye

# Create a group and user without specifying UID and GID
RUN groupadd -r user && useradd -r -g user user

# Set the working directory to /app
WORKDIR /app

# Copy entrypoint.sh before changing the user
COPY ./entrypoint.sh /app/

# Set permissions to ensure the non-root user can execute the entrypoint
RUN chmod +x /app/entrypoint.sh

# Set the ownership of /app to user:user
RUN chown -R user:user /app

# Make the /app directory writable by the group and others
RUN chmod -R 775 /app

# Ensure the /app/kafka directory is writable by UID 1000
RUN mkdir -p /app/kafka && chown -R 1000:1000 /app/kafka && chmod -R 775 /app/kafka

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
