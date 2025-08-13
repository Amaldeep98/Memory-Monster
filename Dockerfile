FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY /target/*.jar /app/root.jar

ENTRYPOINT ["java", "-jar", "root.jar"]

EXPOSE 8088