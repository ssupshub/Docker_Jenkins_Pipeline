# Selecting the base image to build our own customised node.js application microservice
FROM node:20-alpine

# Working directory inside the container
WORKDIR /usr/src/app

# Copying dependencies first to leverage cache
COPY package*.json ./

# Installing node package manager
# install only production dependencies if you want to optimize size, but we need devDependencies for tests if we run them here
RUN npm install

# Copying everything from current location to default location inside the container
COPY . .

# Expose the port
EXPOSE 3000

# Starting the app with CMD
CMD ["npm", "start"]
