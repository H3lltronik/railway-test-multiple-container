# Usa la imagen oficial de kafka-ui
FROM provectuslabs/kafka-ui:latest

# Exponemos el puerto para Kafka UI
EXPOSE 8080

# Configuración por defecto para conectar Kafka UI a tu nodo Kafka
ENV KAFKA_CLUSTERS_0_NAME=kafka-cluster
ENV KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=kafka:9092