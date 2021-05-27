FROM node:12.18-alpine

# tzdata for timzone
RUN apk update 
RUN apk add tzdata
RUN apk add net-tools

ENV NODE_ENV=production

WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production --silent && mv node_modules ../

COPY . .
EXPOSE 3000
HEALTHCHECK --interval=10s --retries 3 --start-period=60s CMD node /healthcheck.js
CMD ["node", "index.js"]
