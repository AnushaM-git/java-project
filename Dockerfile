# Base image
FROM maven:3.8.4-openjdk-8-slim AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml file
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline

# Copy the source code
COPY src/ ./src/

# Build the application
RUN mvn package

# Final image
FROM openjdk:8-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/my-app-1.0.0.jar .

# Set the entry point
ENTRYPOINT ["java", "-jar", "my-app-1.0.0.jar"]
