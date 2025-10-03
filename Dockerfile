# Use Node.js 22 slim
FROM node:22-slim

WORKDIR /src

ENV NODE_ENV=production
# Mediasoup will compile workers instead of downloading
ENV MEDIASOUP_SKIP_WORKER_PREBUILT_DOWNLOAD=true

# Install build dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    python3 \
    python3-pip \
    ffmpeg \
  && rm -rf /var/lib/apt/lists/*

# Copy package files
COPY package*.json ./

# Install deps (needs package-lock.json present!)
RUN npm ci --only=production

# Copy app files
COPY ./app ./app
COPY ./public ./public

# Rename config.template.js → config.js
RUN cp ./app/src/config.template.js ./app/src/config.js

# Clean up build deps to shrink image
RUN apt-get purge -y --auto-remove python3-pip build-essential \
  && npm cache clean --force \
  && rm -rf /tmp/* /var/tmp/* /usr/share/doc/*

# Expose the port Render will set
ENV PORT=10000
EXPOSE 10000

CMD ["npm", "start"]
