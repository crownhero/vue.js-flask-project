#Stage 1: Build vue.js application

FROM node:20 as build

#Install dependencies
RUN apt-get update && \
    apt-get install -y nano nodejs npm
     
WORKDIR /app

RUN git clone https://github.com/hostspaceng/community-challenge.git .
RUN npm install
RUN npm run build

#stage 2: Run the vue.js app with using Nginx as the web server

FROM nginx:alpine

COPY --from=build /app/dist /app/dist
#Expose port 80

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
