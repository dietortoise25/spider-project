# 多阶段构建：构建阶段
FROM node:20-alpine AS builder

# 设置工作目录
WORKDIR /app

# 复制包管理文件
COPY package.json ./

# 安装pnpm
RUN npm install -g pnpm@10.14.0

# 配置pnpm镜像源
RUN pnpm config set registry https://registry.npmmirror.com

# 安装依赖
RUN pnpm install

# 复制源代码
COPY . .

# 构建应用
RUN pnpm build

# 生产阶段：使用Nginx提供静态文件服务
FROM nginx:alpine AS production

# 复制自定义nginx配置
COPY nginx.conf /etc/nginx/nginx.conf

# 复制构建产物到nginx目录
COPY --from=builder /app/dist /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]