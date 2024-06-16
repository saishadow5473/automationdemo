FROM node:12-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ..
RUN npm run build

FROM nginx:alpine
COPY --from:build /app/dist /usr/share/ngnix/html
EXPOSE 80
CMD ["nginx" , "-g" , "daemon off;"]
