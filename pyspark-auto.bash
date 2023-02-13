#!/bin/bash
# A simple Bash script
echo "es requerido Ubuntu-20.04 para esta instalación"
echo "recordarte que en cada instalación previa te pedira tu contraseña, este atent@!"
sudo apt update -y
sudo apt install -y default-jre openjdk-11-jre openjdk-11-jdk
sudo apt install -y wget 
sudo apt install -y vim  
sudo apt install -y python3  
sudo apt install -y python3-pip

source ~/.bashrc
pip install pyspark==3.3.1

if [[ ! -e /opt/spark/spark-3.3.1-bin-hadoop3.tgz ]]; then
    sudo mkdir -p /opt/spark/
    sudo wget https://dlcdn.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz -P /opt/spark/
    sudo tar xvf /opt/spark/spark-3.3.1-bin-hadoop3.tgz  -C /opt/spark/
    if ! grep -R "export PYSPARK_PYTHON=/usr/bin/python3" ~/.bashrc 
    then
        echo "añadiendo variables de entornos no existentes"
        echo 'export SPARK_HOME=/opt/spark/spark-3.3.1-bin-hadoop3.tgz' >> ~/.bashrc
        echo 'export PATH=$PATH:$SPARK_HOME/bin' >> ~/.bashrc
        echo 'export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc
        source ~/.bashrc
    fi
    echo Done!
    exit 1

fi
while true; do
    clear
    read -p "Al parecer se encuentra una previa instalación. Le gustaria reiniciar la instalación de apache spark? yes/no: " yn
    case $yn in
        [Yy]* ) sudo rm -r /opt/spark/spark-3.3.1-bin-hadoop3.tgz
                sudo wget https://dlcdn.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz -P /opt/spark/
                sudo tar xvf /opt/spark/spark-3.3.1-bin-hadoop3.tgz -C /opt/spark/
                if ! grep -R "export PYSPARK_PYTHON=/usr/bin/python3" ~/.bashrc
                then
                    echo "añadiendo variables de entornos no existentes"
                    echo 'export SPARK_HOME=/opt/spark/spark-3.2.1-bin-hadoop3.2' >> ~/.bashrc
                    echo 'export PATH=$PATH:$SPARK_HOME/bin' >> ~/.bashrc
                    echo 'export PYSPARK_PYTHON=/usr/bin/python3' >> ~/.bashrc
                    source ~/.bashrc

                fi
                echo Done!; break;;
        [Nn]* ) exit;;
        * ) echo "Responde yes o  no.";;
    esac
done
