FROM maven:3.9 AS stage1

WORKDIR /myapp

COPY . .

RUN mvn clean install -DskipTests && mv target/*.jar chatapp.jar

#stage 2

FROM gcr.io/distroless/java21-debian12

WORKDIR /myapp

COPY --from=stage1 /myapp/chatapp.jar chatapp.jar

EXPOSE 8080

CMD ["chatapp.jar"]

