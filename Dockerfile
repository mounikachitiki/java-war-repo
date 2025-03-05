FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /ops-app
# Copy source code instead of cloning from GitHub
COPY . .
RUN mvn clean package -DskipTests
# Second Stage: Run with Tomcat
FROM tomcat:10.1-jdk17
WORKDIR /usr/local/tomcat/webapps/
# Copy the generated WAR file from the builder stage
COPY --from=builder /ops-app/target/*.war opskill.war
RUN ls -l /usr/local/tomcat/webapps/ && \
 chmod 644 /usr/local/tomcat/webapps/opskill.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

