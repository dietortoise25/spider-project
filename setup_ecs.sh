#!/bin/bash

# ECS服务器配置脚本
# 使用方法：./setup_ecs.sh <ECS_IP> <SSH_PASSWORD>

ECS_IP=${1:-"8.148.208.237"}
SSH_PASSWORD=${2}

if [ -z "$SSH_PASSWORD" ]; then
    echo "使用方法: $0 <ECS_IP> <SSH_PASSWORD>"
    echo "示例: $0 8.148.208.237 your_password"
    exit 1
fi

# SSH公钥内容
SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQL6172AA3DfW0Sd83SvUMTrQXQ0qlOoK1fRsGyv1pdcfB4E+M38FYOu5LP3317UVWn+u8CfS9pEyAv0LYiHdckxIoXC85MXN/ymN4q1IV9QkMEdbpqD59ERI2d25tec3KRys+dOnHEuGcLL5Y45vMcpyU18ivpOWp38uW/E65XTDcldl4d8Aa9GngqZKoxTIM9s6mpz/QxV30KEEVrLeMgoX+InO5tIBtcgBABete4cJN+/4rS83f8N0cxk4B5Vx++RfQ8GxUX81w//BkBo3T+GPvBME7Zi4AyrmtWopDjppcG/8kNUX182TvYRAqcfR0hLW8A3b2hRPMa3CkJXWktDSrcT1r2yIJBbug9nuv2XTvpxqQyXu70CegIgWgkNWBd9anB7kMnUP35J5NwdCunJOPqy7PvhY+lmlpHRfVEORNJ6s1mE6qdmi2dP4CYnkFzqRFuU4fNBWyeQwcyvOx5g324Pxtg9BrY3RHhXallsC5GABty5uKXvlj1aHWbazO/r10LI+hBOTStogqSSrjhnT9oo/WbKxn2xLYDOish2fI8z8sWrg8NoSHTJ1pdyRAOcls7XVM5vVvDrnnyyMLmi5Prn9OBx1VYrCuws2PIJqVZkqDYuO40nUoaELTF6ewuBurgLI+hPKEBrRLzZhOh808idsYNXNRJdxnvVx1AQ== ecs@spider-project"

echo "正在配置ECS服务器: $ECS_IP"

# 使用expect处理密码登录（如果系统没有expect，需要安装）
if command -v expect >/dev/null 2>&1; then
    expect -c "
        spawn ssh root@$ECS_IP \"mkdir -p ~/.ssh && chmod 700 ~/.ssh\"
        expect \"password:\"
        send \"$SSH_PASSWORD\r\"
        expect eof
    "

    expect -c "
        spawn ssh root@$ECS_IP \"echo '$SSH_PUBLIC_KEY' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys\"
        expect \"password:\"
        send \"$SSH_PASSWORD\r\"
        expect eof
    "

    expect -c "
        spawn ssh root@$ECS_IP \"apt update && apt install -y docker.io docker-compose git\"
        expect \"password:\"
        send \"$SSH_PASSWORD\r\"
        expect eof
    "

    echo "配置完成！现在可以使用密钥登录了"
else
    echo "请手动执行以下步骤："
    echo "1. ssh root@$ECS_IP"
    echo "2. 输入密码后执行："
    echo "   mkdir -p ~/.ssh && chmod 700 ~/.ssh"
    echo "   echo '$SSH_PUBLIC_KEY' >> ~/.ssh/authorized_keys"
    echo "   chmod 600 ~/.ssh/authorized_keys"
    echo "   apt update && apt install -y docker.io docker-compose git"
fi

# 测试密钥登录
echo "测试SSH密钥登录..."
ssh -o BatchMode=yes -o ConnectTimeout=10 root@$ECS_IP "echo 'SSH密钥登录成功！'" && echo "✅ 配置成功" || echo "❌ 配置失败，请检查"