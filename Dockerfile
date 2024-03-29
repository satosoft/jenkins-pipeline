FROM node:alpine
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN apk add --update docker openrc
EXPOSE 3000
CMD npm start
