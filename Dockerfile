# Stage 1: Build the React app
FROM node:alpine as build

WORKDIR /suchith-arella

COPY package*.json ./
RUN npm install

COPY . . 
RUN npm run build

# Use Nginx as the production server
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built React app to Nginx's web server directory
COPY --from=build /suchith-arella/dist /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]