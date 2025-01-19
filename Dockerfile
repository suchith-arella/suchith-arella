# Stage 1: Build the React app
FROM node:alpine as vite-build

WORKDIR /soul-arella

COPY package*.json ./
RUN npm install

COPY . . 
RUN npm run build

# Use Nginx as the production server
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/configfile.template

COPY --from=vite-build /soul-arella/dist /usr/share/nginx/html

# Expose port 8080 to the Docker host, so we can access it 
# from the outside. This is a placeholder; Cloud Run will provide the PORT environment variable at runtime.
ENV PORT 8080
ENV HOST 0.0.0.0
EXPOSE 8080
CMD sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/configfile.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"