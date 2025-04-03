# ==============================
# 1) Build Stage
# ==============================
FROM maven:3.9.3-eclipse-temurin-17 AS build

# Create app directory
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY .mvn .mvn

# Download dependencies (caching layer)
RUN mvn dependency:go-offline

# Copy the source code
COPY src src

# Build the application
RUN mvn clean package -DskipTests

# ==============================
# 2) Run Stage
# ==============================
FROM eclipse-temurin:17-jdk-alpine

# Create a user to run the application (optional but recommended)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Set the entry point
ENTRYPOINT ["java","-jar","/app.jar"]