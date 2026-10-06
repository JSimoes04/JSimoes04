# Etapa 1: compilar o CSS com Tailwind
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Etapa 2: servir o site estático
FROM nginx:alpine
COPY --from=build /app/index.html /app/historia.html /app/selecoes.html /usr/share/nginx/html/
COPY --from=build /app/assets /usr/share/nginx/html/assets
EXPOSE 80
