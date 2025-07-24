FROM openjdk:21
ARG VERSION
COPY target/restaurant-0.0.1-SNAPSHOT.jar /app/restaurant.jar

LABEL maintainer="nominhyeok<minhyeok75@gmail.com>" \
      title="Restaurant App" \
      version="$VERSION" \
      description="This image is restaurant service"

ENV APP_HOME /app
EXPOSE 80
VOLUME /app/upload
WORKDIR $APP_HOME

ENTRYPOINT ["java"]
CMD ["-jar","restaurant.jar"]
