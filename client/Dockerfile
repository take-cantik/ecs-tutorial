# ビルド用のイメージ
FROM node:20-alpine3.18 AS dependencies

RUN apk add --no-cache libc6-compat
WORKDIR /work/src

COPY package.json pnpm-lock.json ./
RUN pnpm install --frozen-lockfile

# 本番用のイメージ
FROM node:20-alpine3.18 AS production

WORKDIR /work/src

COPY --from=dependencies /work/src/node_modules ./node_modules
COPY . .

RUN pnpm run build

EXPOSE 3000

CMD ["pnpm", "run", "start"]
