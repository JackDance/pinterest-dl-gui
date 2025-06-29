# Docker 部署说明

## 概述
本项目已配置为支持Docker部署，默认端口为13100，并使用宿主机网络模式以支持VPN访问外网。

## 部署方式

### 方式一：使用 Docker Compose（推荐）

1. 构建并启动容器：
```bash
docker-compose up -d
```

2. 查看容器状态：
```bash
docker-compose ps
```

3. 查看日志：
```bash
docker-compose logs -f
```

4. 停止容器：
```bash
docker-compose down
```

### 方式二：使用 Docker 命令

1. 构建镜像：
```bash
docker build -t pinterest-dl-gui .
```

2. 运行容器：
```bash
docker run -d \
  --name pinterest-dl-gui \
  --network host \
  -v $(pwd)/downloads:/app/downloads \
  -v $(pwd)/cookies:/app/cookies \
  -p 13100:13100 \
  pinterest-dl-gui
```

3. 查看容器状态：
```bash
docker ps
```

4. 查看日志：
```bash
docker logs -f pinterest-dl-gui
```

5. 停止容器：
```bash
docker stop pinterest-dl-gui
docker rm pinterest-dl-gui
```

## 访问应用

部署完成后，可以通过以下地址访问应用：
- 本地访问：http://localhost:13100
- 局域网访问：http://[服务器IP]:13100

## 重要配置说明

### 网络模式
- 使用 `network_mode: host` 确保容器使用宿主机网络
- 这样容器可以访问宿主机的VPN网络，实现外网访问

### 端口配置
- 应用默认运行在13100端口
- 可通过环境变量 `STREAMLIT_SERVER_PORT` 修改

### 数据持久化
- `downloads/` 目录：存储下载的图片文件
- `cookies/` 目录：存储登录cookies信息
- 这些目录通过volume挂载到宿主机，确保数据持久化

## 环境变量

可以在docker-compose.yml中修改以下环境变量：

- `STREAMLIT_SERVER_PORT`: 服务端口（默认13100）
- `STREAMLIT_SERVER_ADDRESS`: 服务地址（默认0.0.0.0）
- `STREAMLIT_SERVER_HEADLESS`: 无头模式（默认true）
- `STREAMLIT_BROWSER_GATHER_USAGE_STATS`: 禁用使用统计（默认false）

## 故障排除

1. 如果容器无法启动，检查端口是否被占用：
```bash
netstat -tulpn | grep 13100
```

2. 如果无法访问外网，确认宿主机VPN是否正常工作：
```bash
curl -I https://www.pinterest.com
```

3. 查看详细日志：
```bash
docker-compose logs -f pinterest-dl-gui
``` 