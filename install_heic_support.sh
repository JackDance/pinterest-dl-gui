#!/bin/bash

echo "Installing HEIC support for Pinterest DL GUI..."

# 检查操作系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Detected macOS"
    if command -v brew &> /dev/null; then
        echo "Installing libheif via Homebrew..."
        brew install libheif
    else
        echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
        exit 1
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    echo "Detected Linux"
    if command -v apt-get &> /dev/null; then
        echo "Installing libheif-dev via apt..."
        sudo apt-get update
        sudo apt-get install -y libheif-dev libde265-dev
    elif command -v yum &> /dev/null; then
        echo "Installing libheif-devel via yum..."
        sudo yum install -y libheif-devel libde265-devel
    else
        echo "Unsupported package manager. Please install libheif manually."
        exit 1
    fi
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

# 安装Python包
echo "Installing pillow-heif Python package..."
pip install pillow-heif>=0.15.0

echo "HEIC support installation completed!"
echo "You can now run the application with: streamlit run gui.py" 