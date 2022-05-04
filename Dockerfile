
FROM node:16 AS builder
WORKDIR /app

COPY package*.json ./

RUN npm install
COPY . .
RUN npm run build

FROM node:16
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 8080
EXPOSE 3000

CMD [ "npm", "run", "start:prod" ]

