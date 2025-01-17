# Stage 1: Build the React app
FROM node:alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . . 
RUN npm run build

# Stage 2: Serve the app with Nginx

COPY ./dist ./
