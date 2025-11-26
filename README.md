# Spider Project

基于React + Node.js + Docker + GitHub Actions + 阿里云ECS的完整CI/CD流水线项目。

## 🚀 技术栈

- **前端**: React 19 + Vite + TypeScript
- **后端**: Node.js 20 + Express
- **容器化**: Docker + Docker Compose
- **CI/CD**: GitHub Actions
- **部署**: 阿里云ECS

## 🌐 访问地址

- **主页**: http://8.148.208.237
- **API**: http://8.148.208.237/api
- **健康检查**: http://8.148.208.237/health

## 📋 CI/CD流程

1. 代码推送到 `master` 分支
2. GitHub Actions 自动构建和测试
3. Docker 镜像构建
4. 自动部署到阿里云ECS

## 🛠️ 快速开始

```bash
# 克隆项目
git clone https://github.com/alan0125alan0125/spider-project.git
cd spider-project

# 本地开发
docker-compose up -d

# 访问应用
curl http://localhost/health
```

## ✅ 状态

- [x] CI/CD流水线配置完成
- [x] SSH免密登录配置
- [x] Docker镜像加速器配置
- [x] 应用部署成功
- [x] 所有服务健康运行

---

*最后更新: 2025-11-26*