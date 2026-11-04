
# Stage 1: Build dependencies
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

# Stage 2: Final lightweight image
FROM node:22-alpine AS production

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app/node_modules ./node_modules
COPY --chown=node:node server.js ./
COPY --chown=node:node package.json ./

USER node

EXPOSE 3000

CMD ["node", "server.js"]
