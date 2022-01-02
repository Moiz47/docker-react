FROM node:16-alpine as builder
USER node
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

# Run pahse, every 'from' is basically a new phase

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html