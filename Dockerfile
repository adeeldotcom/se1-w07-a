FROM node:alpine AS build-stage
WORKDIR /app
COPY package.json .
RUN npm ci
COPY . .
RUN npx parcel build "/app/src/index.html" --dist-dir "dist" --public-url "./"
FROM nginx:alpine
COPY --from=build-stage "/app/dist" /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

