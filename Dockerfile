# 使用Python 3.11作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖，包括HEIC支持
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    libheif-dev \
    libde265-dev \
    && rm -rf /var/lib/apt/lists/*

# 复制requirements文件并安装Python依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY . .

# 创建必要的目录
RUN mkdir -p downloads cookies

# 设置环境变量
ENV STREAMLIT_SERVER_PORT=13100
ENV STREAMLIT_SERVER_ADDRESS=0.0.0.0
ENV STREAMLIT_SERVER_HEADLESS=true
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

# 暴露端口
EXPOSE 13100

# 设置启动脚本权限
RUN chmod +x start.sh

# 启动应用
CMD ["./start.sh"] 