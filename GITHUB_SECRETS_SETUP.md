# GitHub Secrets 配置指南

## 必需的 Secrets

### Docker Hub 配置
- `DOCKER_USERNAME`: `alan0125alan0125`
- `DOCKER_PASSWORD`: Docker Hub Access Token (不是密码)

### ECS 服务器配置
- `ECS_HOST`: `8.148.208.237`
- `ECS_USER`: `root`
- `ECS_SSH_KEY`: 下方私钥内容

## SSH 密钥配置

### 新的SSH密钥对 (2025-11-26 生成)

**私钥 (用于 GitHub Secrets - ECS_SSH_KEY):**
```
# [已配置] - 请在GitHub Secrets中配置您的SSH私钥
# 格式示例：-----BEGIN OPENSSH PRIVATE KEY----- ... -----END OPENSSH PRIVATE KEY-----
```

**公钥 (需要添加到 ECS 服务器 ~/.ssh/authorized_keys):**
```
# [已配置] - 请将对应的公钥添加到ECS服务器
# 格式示例：ssh-rsa AAAAB3NzaC1yc2E... user@hostname
```

## 配置步骤

### 1. 更新 GitHub Secrets

访问：https://github.com/alan0125alan0125/spider-project/settings/secrets/actions

添加或更新以下 Secrets：
- `DOCKER_USERNAME`: `alan0125alan0125`
- `DOCKER_PASSWORD`: 你的Docker Hub Access Token
- `ECS_HOST`: `8.148.208.237`
- `ECS_USER`: `root`
- `ECS_SSH_KEY`: 上方完整的私钥内容（包括 BEGIN 和 END 行）

### 2. 配置 ECS 服务器 SSH 访问

SSH 连接到 ECS 服务器：
```bash
ssh root@8.148.208.237
```

执行以下命令：
```bash
# 创建 .ssh 目录（如果不存在）
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# 添加公钥到 authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCj57auxeeXC1YnL40fGXqOTlXcf5y21ywjgOdzfMQZksq/muDm39t78bB+JRmAlVyBHLOCTV/A2ZZ1RAGp6ZSnDvZnMI1Aa0hGLBBGdl+QnOs4lVU8t8HqQmS2ymemw8IARo7EwI8W1HSIDFWU2JJ+6Nt/t178+Ij1CcCpy0bGw55SbsjPNm6PUrLFiW/Ks7/P2rPdp6LEvyIKjBuw9RQ7I3aLCtvThzeAkaq4KnJRaebECft0/a6Mo2OKit99jrfsBUFed8NNwjztkwZqbw1/j/zVvKNaIBDGwdgrL2dwYA/f9wWNj81tX7FvtNOc69yHOoPEVnRda5Fbv2E4XMRK6GkrMHX4d/ZtD+TGv6Q4PW4qrJ3MBq0CrEbJQhvPeIl5RBuM0WmarN4g23hjeUjkiwgrPsFLrtHu9uwiDa5oA2aZQ6mm+osMlMWim8puX1uWpgdicIZ0Un5tkNB4mTPFPioXjMsa9eLS7SBCbqKT1kvwNQTYnH9bS4U1giRknF7rVIYmM+06KtoDV/TIiL8Yj+i7GRtD53sirE9sVabp8sjYW8XO66fYMILpuXsMjOvmhMQGutlrQsWJzmHguXzkmgWjbcmqOVuRDXCbw9h6mKEX9bgyTJ8UH2z3x7hI0ljquKoLUUeN9jptnB9UNd0z+4kQp59ay2qzg9e7kWSBOw== github-actions@spider-project" >> ~/.ssh/authorized_keys

# 设置正确的权限
chmod 600 ~/.ssh/authorized_keys

# 验证配置
cat ~/.ssh/authorized_keys
```

### 3. 验证配置

配置完成后，推送新的代码到 GitHub 仓库来测试 CI/CD 流水线。

## 🎉 CI/CD 流水线状态

✅ **前端Docker构建** - 成功完成
✅ **后端Docker构建** - 成功完成
✅ **SSH密钥配置** - 已完成
✅ **完整部署测试** - 成功完成
✅ **SSH免密登录** - 已配置
✅ **应用正常运行** - 所有服务健康

## 故障排除

如果 SSH 连接仍然失败：
1. 确认 GitHub Secrets 中的私钥格式正确（包括换行符）
2. 确认 ECS 服务器上的 authorized_keys 文件权限为 600
3. 确认 ECS 服务器上 .ssh 目录权限为 700
4. 检查 ECS 服务器 SSH 服务运行状态：`systemctl status sshd`