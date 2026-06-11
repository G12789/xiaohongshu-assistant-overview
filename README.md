# Xiaohongshu Merchant Assistant — Architecture Overview

> An AI-powered content system that helps local merchants produce Xiaohongshu (RED) notes, images and video scripts at scale.
>
> This repo is a **public overview only**. The full source is delivered via a commercial license — it is **not** open source.

中文说明见文末。

---

## What it is

I originally built this while doing Xiaohongshu operations for local stores. Writing one usable note by hand took me over an hour — picking the angle, copy, images, layout. It didn't scale, so I turned the workflow into a system: a merchant fills in store info, and a creation pipeline produces the note, images and a video script automatically.

After running it online for a while, I cleaned it up into a deliverable source package for other operators / indie developers who want their own private deployment.

## Stack

| Layer | Tech |
|-------|------|
| Frontend | React + Vite (merchant dashboard + `/admin` panel) |
| Backend | Cloudflare Workers (Hono), 21 route modules |
| Database | Cloudflare D1 (42 migrations) + KV + R2 |
| Sidecars | SMTP bridge (email), video-script service |

## Modules

- **Merchant dashboard** — AI note creation (5-step pipeline), image library, video scripts
- **Business** — plans & quota, referrals, agent/distribution, lightweight CRM, multi-store
- **Admin** — user management, agent management, invite codes, quality logs
- **Content engine** — 7 industries × 116 sub-categories, quality gate to kill generic AI copy

## What makes it not a toy

The hard part wasn't the feature list — it was making the AI stop writing generic filler. A dedicated quality-gate layer rewrites/rejects low-engagement drafts before they reach the merchant. Payments, multi-store and the agent hierarchy are all wired into real flows, not stubs.

## Commercial license

The full sanitized source (worker + pages + smtp-bridge + video service), deployment runbook and a non-exclusive license are delivered as a one-time package. The buyer brings their own Cloudflare account, domain and LLM API keys.

Not included: my customer data, brand/domain, API balance, or ongoing updates.

**Interested?** Open an issue or reach out via the contact listed on my profile. Happy to discuss the architecture in the open.

---

## 中文

一套帮线下商家批量生产小红书笔记 / 配图 / 视频脚本的 AI 系统。本仓库**仅为公开介绍页**，完整源码通过商业授权交付，**非开源**。

- 前端：React + Vite（商家端 + /admin 管理端）
- 后端：Cloudflare Workers（Hono，21 个路由模块）
- 存储：D1（42 次迁移）+ KV + R2
- 旁路：SMTP 邮件桥 + 视频脚本服务

核心不是功能清单，而是一层**质量校验**：在草稿到达商家之前，重写/拦截「假大空」的低质内容。付费、多店、代理分销都接入了真实流程。

源码授权为一次性交付（脱敏源码 + 部署文档 + 非独家授权协议）。买方自备 Cloudflare 账号、域名、AI Key；不含卖方数据、品牌与后续更新。

想了解交付清单的，可提 issue 或通过主页联系方式私信。也欢迎纯架构交流。
