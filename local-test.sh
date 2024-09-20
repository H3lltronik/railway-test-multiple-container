#!/bin/bash

# Crear una red de Docker
docker network create kafka-network

# Variables para los nombres de los contenedores
KAFKA_CONTAINER_NAME="kafka"
KAFKA_UI_CONTAINER_NAME="kafka-ui"

# Detiene contenedores anteriores si es necesario
echo "Deteniendo contenedores anteriores si es necesario..."
docker stop $KAFKA_CONTAINER_NAME $KAFKA_UI_CONTAINER_NAME 2>/dev/null || true
docker rm $KAFKA_CONTAINER_NAME $KAFKA_UI_CONTAINER_NAME 2>/dev/null || true

# Construir la imagen de Kafka (desde el Dockerfile en la carpeta kafka)
echo "Construyendo la imagen de Kafka..."
docker build -t my-kafka ./kafka

# Lanzar el contenedor de Kafka en la red "kafka-network"
echo "Lanzando el contenedor de Kafka..."
docker run -d \
  --name $KAFKA_CONTAINER_NAME \
  --network kafka-network \
  -p 9092:9092 \
  -p 9093:9093 \
  my-kafka

# Esperar a que Kafka esté listo antes de iniciar Kafka UI
echo "Esperando a que Kafka esté completamente listo..."
sleep 30  # Aumentado el tiempo de espera a 30 segundos

# Construir la imagen de Kafka UI (desde el Dockerfile en la carpeta kafka-ui)
echo "Construyendo la imagen de Kafka UI..."
docker build -t my-kafka-ui ./kafka-ui

# Lanzar el contenedor de Kafka UI en la red "kafka-network"
echo "Lanzando el contenedor de Kafka UI..."
docker run -d \
  --name $KAFKA_UI_CONTAINER_NAME \
  --network kafka-network \
  -p 8080:8080 \
  my-kafka-ui

# Mostrar el estado de los contenedores
echo "Contenedores en ejecución:"
docker ps

# Mostrar información para acceder a Kafka UI
echo "Kafka UI debería estar corriendo en http://localhost:8080"
