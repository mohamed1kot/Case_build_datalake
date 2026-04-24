FROM python:3.11-bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-17-jdk \
    curl \
    wget \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV SPARK_HOME="/opt/spark"
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
ENV PATH="${JAVA_HOME}:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"

RUN mkdir -p ${SPARK_HOME} \
    && mkdir -p /opt/spark/events \
    && mkdir -p /opt/spark/logs

WORKDIR ${SPARK_HOME}

ENV SPARK_VERSION=3.5.1

RUN curl -L https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -o spark.tgz && \
    tar -xvzf spark.tgz --strip-components 1 && \
    rm spark.tgz

RUN pip install --no-cache-dir \
    pyspark==3.5.1 \
    jupyterlab \
    notebook \
    pandas \
    numpy \
    pyarrow \
    findspark

RUN rm -f /opt/spark/jars/rapids-4-spark*.jar

RUN wget https://repo1.maven.org/maven2/com/nvidia/rapids-4-spark_2.12/24.06.0/rapids-4-spark_2.12-24.06.0.jar \
    -P /opt/spark/jars/

ENV SPARK_MASTER_PORT="7077"
ENV SPARK_MASTER_HOST="spark-master"
ENV SPARK_EVENTLOG_ENABLED="true"
ENV SPARK_EVENTLOG_DIR="/opt/spark/events"

COPY ./spark-defaults.conf "${SPARK_HOME}/conf"

WORKDIR /workspace

ENTRYPOINT ["/bin/bash"]