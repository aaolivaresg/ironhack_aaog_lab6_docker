# Build Stage
FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Test Stage
FROM build AS test
RUN npm test

# Deployment Stage
FROM node:14 AS production
WORKDIR /app
COPY --from=build /app /app
EXPOSE 3000
CMD ["npm", "start"]
