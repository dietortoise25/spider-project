# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目架构

这是一个全栈JavaScript项目，包含React前端和Node.js后端，采用Docker容器化部署和GitHub Actions CI/CD流水线。

### 项目结构
```
spider-project/
├── frontend/          # React + TypeScript + Vite前端
├── backend/           # Node.js后端
├── .github/workflows/ # GitHub Actions CI/CD配置
├── docker-compose.yml # Docker编排文件
└── nginx/            # Nginx配置（反向代理）
```

### 技术栈
- **前端**: React 19.2.0 + TypeScript + Vite 7.2.4
- **后端**: Node.js (待定框架)
- **容器化**: Docker + docker-compose
- **CI/CD**: GitHub Actions
- **部署**: 阿里云ECS + 容器镜像服务

## 开发命令

### 前端开发
```bash
cd frontend
pnpm install          # 安装依赖
pnpm dev             # 启动开发服务器 (http://localhost:5173)
pnpm build           # 构建生产版本
pnpm lint            # 代码检查
pnpm preview         # 预览构建结果
```

### 后端开发
```bash
cd backend
pnpm install          # 安装依赖
# 后端框架和启动命令待定
```

### Docker开发
```bash
# 构建并启动所有服务
docker-compose up --build

# 后台运行
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down

# 清理镜像和容器
docker-compose down --rmi all
```

### Git工作流
```bash
# 添加文件
git add .

# 提交代码（会触发GitHub Actions）
git commit -m "feat: add new feature"

# 推送到远程仓库（触发CI/CD部署）
git push origin main
```

## CI/CD流水线

### GitHub Actions触发条件
- push到main分支：触发完整构建和部署
- pull request：仅运行测试和构建检查

### 部署流程
1. 代码检出 → 2. 依赖安装 → 3. 代码测试 → 4. Docker构建 → 5. 镜像推送 → 6. ECS部署

### 环境变量配置
项目使用GitHub Secrets管理敏感信息：
- `DOCKER_REGISTRY`: 容器仓库地址
- `DOCKER_USERNAME`: Docker用户名
- `DOCKER_PASSWORD`: Docker密码
- `ECS_SSH_KEY`: ECS服务器SSH私钥
- `ECS_HOST`: ECS服务器IP地址

## 部署架构

### 容器化方案
- **多容器架构**: 前端、后端、Nginx分别独立容器
- **反向代理**: Nginx处理静态文件和API路由
- **网络隔离**: 使用Docker网络进行容器间通信

### 端口分配
- 前端容器: 3000
- 后端容器: 8000
- Nginx容器: 80, 443

## 开发注意事项

### 包管理
- 项目统一使用pnpm作为包管理器
- pnpm版本: 10.14.0
- 前端已有完整依赖，后端待配置

### Git忽略规则
已配置.gitignore忽略：
- node_modules/ (所有层级)
- 构建输出 (dist/, build/)
- 环境变量文件 (.env*)
- IDE配置文件
- Docker相关文件

### TypeScript配置
前端使用TypeScript，配置文件：
- tsconfig.json: 主配置
- tsconfig.app.json: 应用代码配置
- tsconfig.node.json: 构建工具配置

## 待完成项目

1. 后端框架选择和配置
2. Dockerfile创建 (frontend/backend)
3. docker-compose.yml编排
4. GitHub Actions工作流配置
5. Nginx反向代理配置
6. 阿里云ECS服务器准备
7. 容器镜像仓库配置
8. 部署脚本编写