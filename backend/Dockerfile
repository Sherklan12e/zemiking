FROM node:20-bullseye
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .
RUN mkdir -p src/public/uploads && chmod 777 src/public/uploads

EXPOSE 3000
CMD ["npm", "start"]