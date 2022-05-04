
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

# Puerto de tu aplicación, en nuestro caso está escuchando el 3000 ( app.listen) en el archivo main.ts
# No hace falta poner 8080 eso es en localhost que se pone con el 
# comando docker run -p 3000/8080 (el 8080 no va por comando si, si se pone en la interfaz) o en la intefaz de docker
EXPOSE 3000 

CMD [ "npm", "run", "start:prod" ]

# iniciar con docker build . -t rafatest
# Cambiar puerto, tras hacer el build poner docker run -p 3000 y la tag que hayas puesto

