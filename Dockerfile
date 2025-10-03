# Use Node.js 22 slim image
FROM node:22-slim

# Set working directory
WORKDIR /src

# Environment variables
ENV NODE_ENV=production

# Install necessary system packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        python3 \
    && rm -rf /var/lib/apt/lists/*

# Copy package files first (for caching)
COPY package*.json ./

# Install npm dependencies (downloads mediasoup prebuilt workers automatically)
RUN npm ci --only=production --silent

# Copy application code
COPY ./app ./app
COPY ./public ./public

# Rename config file
RUN cp ./app/src/config.template.js ./app/src/config.js

# Clean up cache and unnecessary files
RUN npm cache clean --force \
    && rm -rf /tmp/* /var/tmp/* /usr/share/doc/*

# Render sets $PORT automatically — ensure app listens on it
ENV PORT=10000
EXPOSE 10000

# Start the app
CMD ["npm", "start"]
