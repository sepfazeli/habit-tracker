# ─── STAGE 1: deps ───────────────────────────────────────────────────────────────
FROM node:18-alpine AS deps
WORKDIR /app

# Enable Corepack and activate pnpm
RUN corepack enable \
 && corepack prepare pnpm@latest --activate

COPY package*.json ./
RUN pnpm install --frozen-lockfile

# ─── STAGE 2: builder ───────────────────────────────────────────────────────────
FROM node:18-alpine AS builder
WORKDIR /app

# Bring in deps + source, then build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN pnpm build

# ─── STAGE 3: runner ────────────────────────────────────────────────────────────
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

# Copy only what’s needed to run
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000
CMD ["pnpm", "start"]
