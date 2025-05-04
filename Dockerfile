# -------- STAGE 1: Build Stage --------
    FROM node:18 AS builder

    WORKDIR /app
    
    # Install dependencies only
    COPY package.json package-lock.json ./
    RUN npm ci --only=production
    
    # Copy app source
    COPY . .
    
    # -------- STAGE 2: Run Stage --------
    FROM node:18-slim
    
    WORKDIR /app
    
    # Copy only the built app and production deps
    COPY --from=builder /app ./
    
    EXPOSE 3000
    CMD ["node", "index.js"]
    