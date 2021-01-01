FROM clojure:lein AS build
RUN apt-get update
RUN apt-get install -y --no-install-recommends make

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash
RUN apt-get install -y nodejs
RUN node -v
RUN npm -v

WORKDIR /app

COPY . .

RUN lein deps
RUN lein release

FROM nginx as app
COPY --from=build /app/resources/public /usr/share/nginx/html
