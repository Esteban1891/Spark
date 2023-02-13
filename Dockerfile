#Download base image ubuntu 20.04
FROM ubuntu:20.04
RUN  apt update -y
# Install java, wget, vim, python3 and pip from ubuntu repository
RUN apt install -y default-jre openjdk-11-jre openjdk-11-jdk
RUN apt install -y wget 
RUN apt install -y vim  python3  python3-pip
WORKDIR /opt/spark/
RUN wget https://dlcdn.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz
RUN tar xvf spark-3.3.1-bin-hadoop3.tgz
RUN echo 'export SPARK_HOME=/opt/spark/spark-3.3.1-bin-hadoop3' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$SPARK_HOME/bin' >> ~/.bashrc
RUN echo 'export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc
RUN pip install pyspark
RUN  /bin/bash -c "source ~/.bashrc"
WORKDIR /src/project/
