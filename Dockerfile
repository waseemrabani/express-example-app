# Use an official image as the base image for the builder stage
FROM node AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the application
# Use an official image as the base image for the release stage
FROM node

# Set the working directory in the container
WORKDIR /app
# Copy the built files from the builder stage
COPY --from=builder /app/node_modules /app/node_modules
COPY --from=builder /app/package*.json /app/
COPY --from=builder /app/index.js /app/
COPY --from=builder /app/server.js /app/
COPY --from=builder /app/test.js /app/
#Port
EXPOSE 3000
# Specify the command to run when the container starts
CMD [ "npm", "start" ]
