# Use the official Node.js image as a base image
FROM node:16-alpine as build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies (optional, since packages are already installed)
# RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Use the official Node.js image for serving the Angular app
FROM node:16-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the built Angular app from the 'build' stage to the working directory
COPY --from=build /usr/src/app/dist/my-angular-app .

# Expose port 80 to the outside world
EXPOSE 80

# Start Node.js server to serve the Angular app
CMD ["npx", "http-server", "-p", "80"]
