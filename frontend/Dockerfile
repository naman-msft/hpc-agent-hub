FROM node:20-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install

# ✅ AUTOMATIC CACHE BUSTER - Uses git commit SHA from GitHub Actions
ARG CACHEBUST=dev
RUN echo "Building from commit: $CACHEBUST"

# ✅ INJECT BUILD VERSION (forces different bundle content)
ENV REACT_APP_BUILD_VERSION=$CACHEBUST

COPY . .

# ✅ NUCLEAR: Delete ALL possible caches including build artifacts
RUN rm -rf node_modules/.cache build .cache

# ✅ Force Webpack to see files as "changed" by touching them
RUN find src -type f -exec touch {} +

RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]