# ─── STAGE 1: deps ───────────────────────────────────────────────────────────────
FROM node:18-alpine AS deps
WORKDIR /app

RUN corepack enable \
 && corepack prepare pnpm@latest --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# ─── STAGE 2: builder (inherits deps, so pnpm is available) ───────────────────────
FROM deps AS builder
WORKDIR /app

COPY . .
RUN pnpm build

# ─── STAGE 3: runner ──────────────────────────────────────────────────────────────
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["pnpm", "start"]
