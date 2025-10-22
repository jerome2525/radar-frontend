# Use Node.js 18 as base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package.json package-lock.json ./

# Install dependencies (using install instead of ci to avoid sync issues)
RUN npm install --silent

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Install serve globally for production
RUN npm install -g serve

# Expose port
EXPOSE 3000

# Start the application
CMD ["serve", "-s", "build", "-l", "3000"]
