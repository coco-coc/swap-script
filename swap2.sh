#!/bin/bash

SWAPFILE="/swapfile"
FSTAB="/etc/fstab"
BACKUP="/etc/fstab.back"

read -p "请输入 Swap 大小（例如 512M、1G、8G，默认 1G）: " USER_SWAPSIZE
SWAPSIZE=${USER_SWAPSIZE:-1G}

echo "1. 创建 $SWAPSIZE 的交换文件..."
fallocate -l $SWAPSIZE $SWAPFILE || { echo "fallocate 失败，使用 dd"; dd if=/dev/zero of=$SWAPFILE bs=1M count=100; }

echo "2. 设置权限为 600..."
chmod 600 $SWAPFILE

echo "3. 格式化为 swap..."
mkswap $SWAPFILE

echo "4. 启用 swap..."
swapon $SWAPFILE || { echo "swapon 失败，尝试 chmod 和 chown 修复"; chmod 600 $SWAPFILE && chown root:root $SWAPFILE && swapon $SWAPFILE; }

echo "5. 当前 swap 使用情况："
free -h
swapon --show

echo "6. 备份 $FSTAB 到 $BACKUP..."
cp $FSTAB $BACKUP

echo "7. 添加开机自动挂载配置..."
if ! grep -q "$SWAPFILE" $FSTAB; then
    echo "$SWAPFILE none swap sw 0 0" >> $FSTAB
    echo "添加成功"
else
    echo "fstab 中已经存在相关条目，跳过添加"
fi

echo "完成！"
