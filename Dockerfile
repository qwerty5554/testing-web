FROM eclipse-temurin:25-jdk-alpine
WORKDIR /app
COPY target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]
