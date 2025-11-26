# CI/CD 流水线配置指南

## ✅ 已完成
- [x] Docker Hub 仓库创建：`alan0125alan0125/spider-frontend` 和 `alan0125alan0125/spider-backend`
- [x] GitHub Actions 工作流文件创建
- [x] Docker 相关配置文件创建

## 🔧 下一步配置

### 1. 生成 Docker Hub Access Token

1. 登录 [Docker Hub](https://hub.docker.com/)
2. 点击右上角头像 → Account Settings
3. 选择 Security → New Access Token
4. 配置信息：
   ```
   Token name: github-actions
   Scopes: Read, Write, Delete
   ```
5. **重要：复制并保存这个 Token**（只显示一次）

### 2. 重置阿里云 ECS 实例

1. 登录 [阿里云控制台](https://ecs.console.aliyun.com/)
2. 找到你的 ECS 实例
3. 选择更多 → 磁盘和镜像 → 重置系统盘
4. 选择镜像：
   ```
   操作系统：Ubuntu 22.04 LTS
   系统盘大小：50GB
   ```
5. 确认重置

### 3. 配置 ECS 安全组

1. 在 ECS 控制台找到安全组
2. 配置规则，开放端口：
   ```
   HTTP(80)：0.0.0.0/0
   HTTPS(443)：0.0.0.0/0
   SSH(22)：0.0.0.0/0
   ```

### 4. 记录 ECS 信息

重置完成后，记录：
- ECS 公网 IP 地址
- SSH 登录用户名（通常是 `root`）

### 5. 配置 GitHub Secrets

在你的 GitHub 仓库中：

1. 进入仓库 → Settings → Secrets and variables → Actions
2. 点击 "New repository secret"，添加以下 Secrets：

| Secret 名称 | 值 | 说明 |
|------------|-----|------|
| `DOCKER_USERNAME` | `alan0125alan0125` | Docker Hub 用户名 |
| `DOCKER_PASSWORD` | `你的Access Token` | Docker Hub Access Token |
| `ECS_HOST` | `你的ECS公网IP` | ECS 服务器 IP 地址 |
| `ECS_USER` | `root` | ECS 登录用户名 |
| `ECS_SSH_KEY` | `你的SSH私钥` | ECS SSH 私钥 |

### 6. 获取 SSH 密钥

如果你没有 SSH 密钥：

1. 在本地生成 SSH 密钥对：
   ```bash
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/ecs_key
   ```

2. 将公钥添加到 ECS：
   ```bash
   ssh-copy-id -i ~/.ssh/ecs_key.pub root@你的ECS_IP
   ```

3. 复制私钥内容：
   ```bash
   cat ~/.ssh/ecs_key
   ```
   将输出的内容配置为 `ECS_SSH_KEY` 的值。

## 🚀 测试流水线

完成上述配置后：

1. 提交代码到 GitHub：
   ```bash
   git add .
   git commit -m "feat: add CI/CD configuration"
   git push origin main
   ```

2. 在 GitHub 仓库中查看 Actions 标签页
3. 等待流水线执行完成

## 🌐 访问应用

部署成功后，访问：
- `http://你的ECS_IP` - 查看应用

## 📋 故障排查

### 常见问题：

1. **Docker Hub 登录失败**
   - 检查 DOCKER_USERNAME 和 DOCKER_PASSWORD
   - 确保 Access Token 有正确权限

2. **SSH 连接失败**
   - 检查 ECS_HOST 和 ECS_SSH_KEY
   - 确保 ECS 安全组开放了 22 端口
   - 检查 SSH 密钥格式

3. **容器启动失败**
   - 查看部署日志中的详细错误信息
   - 检查 Docker Compose 配置

### 调试命令（在 ECS 服务器上）：

```bash
# 查看容器状态
docker-compose ps

# 查看容器日志
docker-compose logs frontend
docker-compose logs backend
docker-compose logs nginx

# 重启服务
docker-compose restart

# 查看服务健康状态
curl http://localhost/health
```

## 📞 获取帮助

如果遇到问题，请提供：
- GitHub Actions 执行日志
- ECS 服务器上的错误信息
- 具体的错误步骤和截图