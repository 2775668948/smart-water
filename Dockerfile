# build stage
FROM node:12.6.0-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install -g cnpm
RUN cnpm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
