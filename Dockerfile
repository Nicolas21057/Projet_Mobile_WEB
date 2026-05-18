FROM node:24-slim AS base 
ENV CI=true

RUN apt-get update -y && apt-get install -y openssl

RUN npm install -g pnpm@10.28.0 

COPY . /usr/src/app
WORKDIR /usr/src/app 

RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install

ARG DATABASE_URL=postgresql://postgres:password@postgres:5432/my-app
ENV DATABASE_URL=$DATABASE_URL

RUN pnpm --filter db exec prisma generate

EXPOSE 3001

CMD ["sh", "-c", "pnpm --filter db exec prisma db push && pnpm --filter web dev --host"]