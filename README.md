
# 🚀 Habit-Tracker

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Clone & Install](#clone--install)
  - [Development Mode](#development-mode)
  - [Docker & Compose](#docker--compose)
  - [Kubernetes Deployment](#kubernetes-deployment)
- [API Routes & SSR](#api-routes--ssr)
- [Testing](#testing)
  - [Unit Tests (Jest)](#unit-tests-jest)
  - [E2E Tests (Playwright)](#e2e-tests-playwright)
- [CI / CD](#ci--cd)
  - [GitHub Actions](#github-actions)
  - [Nightly Matrix](#nightly-matrix)
- [Contributing](#contributing)
- [Roadmap](#roadmap)
- [License](#license)

## 🧐 Overview

Habit-Tracker is a portfolio-ready Next.js + TypeScript PWA that helps users build and maintain daily habits. It leverages Next.js full-stack capabilities—SSR, API routes, and image optimization—alongside modern best practices: unit tests, E2E flows, CI/CD pipelines, Docker, Kubernetes manifests, and more.

## ✨ Features

- **Create & Manage Habits**: Add, edit, delete daily tasks via built-in API routes.
- **Server-Side Rendering**: Fast first paint and SEO-friendly pages rendered on the server.
- **Image Optimization**: Automatic resizing and modern formats via Next.js `<Image>` component.
- **Progress Dashboard**: View streaks and statistics with dynamic charting.
- **Dark Mode**: Toggle based on system or user preference.
- **Offline-First**: IndexedDB caching via service worker.
- **Notifications**: Browser reminders via PWA API.

## 🛠 Tech Stack

| Layer              | Technology                      |
|--------------------|---------------------------------|
| Framework          | Next.js 14 + TypeScript         |
| Styling            | Tailwind CSS + DaisyUI          |
| State & Data       | React Query, Zustand            |
| Forms & Validation | React Hook Form, Zod            |
| API Routes         | Next.js API Routes (Node.js/Express style) |
| SSR & SSG          | Next.js getServerSideProps & getStaticProps |
| Image Optimization | Next.js `<Image>` component     |
| Testing            | Jest, React Testing Library, Playwright |
| CI/CD              | GitHub Actions                  |
| Containerization   | Docker, docker-compose          |
| Orchestration      | Kubernetes (manifests)          |

## 📦 Prerequisites

- Node.js ≥18
- pnpm (or npm/yarn)
- Docker & Docker Compose
- kubectl
- (Optional) Helm

## 🚀 Getting Started

### Clone & Install

```bash
git clone git@github.com:your-username/habit-tracker.git
cd habit-tracker
pnpm install
```

Development Mode
```bash


pnpm dev
# app available at http://localhost:3000
```
🐋 Docker & Compose
Build & Run:

```bash


docker-compose up --build
# web: http://localhost:3000, db: postgres://postgres:postgres@localhost:5432/habit_tracker
```
Stop & Cleanup:

```bash

docker-compose down --volumes
```
☸️ Kubernetes Deployment
Build & push image (example with Docker Hub):
```bash


docker build -t your-dockerhub-user/habit-tracker:latest .
docker push your-dockerhub-user/habit-tracker:latest
```
Apply manifests:
```bash


kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```
Access:

```bash

kubectl port-forward svc/habit-tracker 3000:80
Visit http://localhost:3000
```
📡 API Routes & SSR
API Routes: Endpoints under /pages/api/* for CRUD operations on habits.
SSR: Use getServerSideProps for dynamic data (e.g., dashboard) and getStaticProps for static pages (e.g., about).
Image Component: <Image> with automatic formatting, resizing, and placeholder blur.
🧪 Testing
Unit Tests (Jest)
```bash

pnpm test        # run once
pnpm test:watch  # watch mode
pnpm test:ci     # CI mode with coverage
```
E2E Tests (Playwright)
```bash



pnpm test:e2e
# generates HTML trace in playwright-report/
```
⚙️ CI / CD
GitHub Actions
Workflow: .github/workflows/ci.yml
Triggers: push → main, PR → main, nightly @ 02:00 UTC
Matrix: macOS & Ubuntu × Chromium & Firefox
Steps: pnpm install, unit tests, E2E tests, artifact upload on failure
Nightly Matrix
Automated nightly cron job runs the full test suite across all platforms to detect environment drift or flaky behavior early.

🤝 Contributing
Fork the repo
Create a branch: feat/<description> or fix/<description>
Commit with Conventional Commits
Push & open a PR against main
Ensure CI is green
📈 Roadmap
📄 License
Released under the MIT License.

