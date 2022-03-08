# ########## faild
# FROM alpine:3.5 AS base

# RUN apk add --no-cache nodejs npm tini
# WORKDIR /app
# ENTRYPOINT ["/sbin/tini", "--"]
# COPY package.json .npmrc ./

# FROM base AS dependencies
# RUN npm install

# FROM dependencies AS test
# COPY . .
# RUN npm run lint && npm run test
# RUN npm run build
# RUN npm prune --production

# FROM test AS release
# COPY --from=test /app/node_modules ./node_modules
# COPY --from=test /app/package*.json ./
# COPY --from=test /app/dist ./dist
# EXPOSE $SERVER_PORT
# CMD [ "npm", "run", "start:prod" ]

################ Old way
FROM node:16.14.0-alpine3.15 as build_stage

WORKDIR /app
COPY package*.json ./
RUN NODE_ENV=development npm ci
COPY . .
RUN npm run build
RUN npm prune --production

FROM node:16.14.0-alpine3.15

WORKDIR /app
COPY --from=build_stage /app/node_modules ./node_modules
COPY --from=build_stage /app/package*.json ./
COPY --from=build_stage /app/dist ./dist

CMD [ "npm", "run", "start:prod" ]

EXPOSE $SERVER_PORT