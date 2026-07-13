FROM maven:3.9.11-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src
RUN mvn -q -DskipTests package

FROM tomcat:10.1.28-jdk21-temurin

ENV CATALINA_OPTS="-Xms256m -Xmx512m"

COPY --from=build /app/target/FoodVerse.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
