FROM node:16.14.0-alpine3.15 as build_stage

WORKDIR /app
COPY package*.json ./
# COPY prisma ./prisma/
# RUN NODE_ENV=development npx yarn install
RUN NODE_ENV=development npm ci
COPY . .
# RUN npx prisma generate
RUN npm run build
RUN npm prune --production

FROM node:16.14.0-alpine3.15

WORKDIR /app
# RUN mkdir /app/pgdata
COPY --from=build_stage /app/node_modules ./node_modules
COPY --from=build_stage /app/package*.json ./
COPY --from=build_stage /app/dist ./dist

CMD [ "npm", "run", "start:prod" ]

EXPOSE $SERVER_PORT