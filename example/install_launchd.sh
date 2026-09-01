#!/bin/sh
# ─────────────────────────────────────────────────────────────
# FasterEdge 开源项目
# Github: https://github.com/FasterEdge
# Gitee:  https://gitee.com/FasterEdge
# ─────────────────────────────────────────────────────────────
# DontCrack macOS 版 - launchd 服务安装脚本
# 用法: sudo ./install_launchd.sh
#
# 前置条件:
#   1. sudo mkdir -p /usr/local/bin /var/lib/dontcrack /var/log/dontcrack
#   2. sudo cp dontcrack-mac /usr/local/bin/dontcrack-mac
#   3. 把要托管的目标进程放到 /usr/local/bin/ 或任意 PATH 中
#   4. 按需修改本目录 com.fasteredge.dontcrack.plist 中的 -path / -args

set -e

PLIST="com.fasteredge.dontcrack.plist"
LABEL="com.fasteredge.dontcrack"

echo "安装 $LABEL 到 ~/Library/LaunchAgents ..."
mkdir -p "$HOME/Library/LaunchAgents"
cp "$PLIST" "$HOME/Library/LaunchAgents/$PLIST"

echo "加载并启动服务..."
launchctl unload "$HOME/Library/LaunchAgents/$PLIST" 2>/dev/null || true
launchctl load "$HOME/Library/LaunchAgents/$PLIST"
launchctl start "$LABEL"

echo "完成。查看运行状态: launchctl list | grep dontcrack"
echo "查看日志: tail -f /var/log/dontcrack/manager.stdout.log"
