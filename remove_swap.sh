#!/bin/bash

SWAPFILE="/swapfile"
FSTAB="/etc/fstab"
BACKUP="/etc/fstab.back"

echo "1. 关闭 swap..."
sudo swapoff $SWAPFILE

echo "2. 删除 swap 文件..."
if [ -f "$SWAPFILE" ]; then
    sudo rm -f $SWAPFILE
    echo "已删除 $SWAPFILE"
else
    echo "$SWAPFILE 不存在，跳过删除"
fi

echo "3. 从 $FSTAB 移除开机挂载配置..."
sudo sed -i "\|$SWAPFILE|d" $FSTAB

echo "4. 显示当前 swap 使用情况："
swapon --show

echo "完成！"
