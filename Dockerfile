FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

COPY . .

# ✅ Make mvnw executable
RUN chmod +x mvnw

RUN ./mvnw package -DskipTests

# Runtime image
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
