# FROM node:22 AS base
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install

# # Don't use root user
# USER node

# EXPOSE 3333

# FROM base AS development
# COPY . .
# CMD ["npm", "run", "dev"]


# FROM base AS production
# COPY . .
# RUN npm prune --production
# CMD ["npm", "run", "start"]



# FROM node:22 as base

# EXPOSE 3333


# # All deps stage
# FROM base as deps
# WORKDIR /app
# ADD package.json package-lock.json ./

# FROM base as development
# WORKDIR /app
# ADD package.json package-lock.json ./
# RUN npm install
# COPY . .
# CMD ["npm", "run", "dev"]


# # Production only deps stage
# FROM base as production-deps
# WORKDIR /app
# ADD package.json package-lock.json ./
# RUN npm ci --omit=dev

# # Build stage
# FROM base as build
# WORKDIR /app
# COPY --from=deps /app/node_modules /app/node_modules
# ADD . .
# RUN node ace build

# # Production stage
# FROM base
# ENV NODE_ENV=production
# WORKDIR /app
# COPY --from=production-deps /app/node_modules /app/node_modules
# COPY --from=build /app/build /app
# CMD ["node", "./bin/server.js"]


# ARG NODE_IMAGE=node:22

# FROM $NODE_IMAGE AS base
# RUN mkdir -p /app && chown node:node /app
# WORKDIR /app/
# USER node
# RUN mkdir tmp

# FROM base AS dependencies
# COPY --chown=node:node ./package*.json ./
# RUN npm install
# COPY --chown=node:node . .

# FROM base AS development
# ENV NODE_ENV=development
# COPY --chown=node:node ./package*.json ./
# RUN npm install
# CMD ["npm", "run", "dev"]


# stage 1 - base

ARG NODE_IMAGE=node:20.12.2-alpine3.18


FROM $NODE_IMAGE AS base
RUN apk --no-cache add dumb-init
RUN mkdir -p /app && chown node:node /app
WORKDIR /app
USER node
RUN mkdir tmp

# stage 2 - dependencies

FROM base AS dependencies
COPY --chown=node:node ./package*.json ./
RUN npm ci
COPY --chown=node:node . .
