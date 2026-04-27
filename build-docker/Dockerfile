FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

COPY target/*.jar app.jar
COPY opentelemetry-javaagent.jar /app/opentelemetry-javaagent.jar

ENTRYPOINT ["java","-javaagent:/app/opentelemetry-javaagent.jar","-jar","/app/app.jar"]
