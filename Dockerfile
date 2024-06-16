# Stage 1: Build the Angular application
FROM node:16-alpine AS build
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Copy the angular.json and other configuration files
COPY angular.json ./
COPY tsconfig*.json ./
COPY src/ ./src/

# Install dependencies
RUN npm install

# Build the Angular application
RUN npm run build -- --output-path=dist/automationdemo

# Stage 2: Serve the Angular application with Nginx
FROM nginx:alpine

# Copy the built Angular application from the previous stage
COPY --from=build /app/dist/automationdemo /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
