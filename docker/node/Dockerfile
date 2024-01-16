FROM node:20-alpine3.18 AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

# ビルド用のイメージ
FROM base AS dependencies

RUN apk add --no-cache libc6-compat
WORKDIR /work/src

COPY client .
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm run build

# 本番用のイメージ
FROM base AS production

WORKDIR /work/src

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=dependencies /work/src/.next/standalone ./
COPY --from=dependencies /work/src/.next/static ./.next/static
COPY --from=dependencies /work/src/public ./public

USER nextjs

EXPOSE 3000

CMD ["node", "server.js"]
