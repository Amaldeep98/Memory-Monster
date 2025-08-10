FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY /target/*.jar /app/root.jar

ENTRYPOINT ["java", "-jar", "root.jar"]

EXPOSE 8088