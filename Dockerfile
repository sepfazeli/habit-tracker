# ─── STAGE 1: deps ───────────────────────────────────────────────────────────────
FROM node:18-alpine AS deps
WORKDIR /app

# Enable Corepack & activate pnpm
RUN corepack enable \
 && corepack prepare pnpm@latest --activate

# Copy package + lockfile, then install deps
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# ─── STAGE 2: builder ───────────────────────────────────────────────────────────
FROM deps AS builder
WORKDIR /app

COPY . .
RUN pnpm build

# ─── STAGE 3: runner ────────────────────────────────────────────────────────────
FROM node:18-alpine AS runner
WORKDIR /app

# Install pnpm globally so it's available here
RUN npm install -g pnpm

ENV NODE_ENV=production

# Copy build artifacts, modules, and package.json (for start script)
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY package.json ./

EXPOSE 3000
CMD ["pnpm", "start"]
