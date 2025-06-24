# 使用 Node.js 來建置前端
FROM node:lts AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# 使用 nginx 來部署靜態檔案
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8272
CMD ["nginx", "-g", "daemon off;"]
