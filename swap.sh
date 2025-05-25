#!/bin/bash

SWAPFILE="/swapfile"
SWAPSIZE="1G"
FSTAB="/etc/fstab"
BACKUP="/etc/fstab.back"

echo "1. 创建 $SWAPSIZE 的交换文件..."
sudo fallocate -l $SWAPSIZE $SWAPFILE || { echo "fallocate 失败"; exit 1; }

echo "2. 设置权限为 600..."
sudo chmod 600 $SWAPFILE

echo "3. 格式化为 swap..."
sudo mkswap $SWAPFILE

echo "4. 启用 swap..."
sudo swapon $SWAPFILE

echo "5. 当前 swap 使用情况："
swapon --show

echo "6. 备份 $FSTAB 到 $BACKUP..."
sudo cp $FSTAB $BACKUP

echo "7. 添加开机自动挂载配置..."
if ! grep -q "$SWAPFILE" $FSTAB; then
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a $FSTAB > /dev/null
    echo "添加成功"
else
    echo "fstab 中已经存在相关条目，跳过添加"
fi

echo "完成！"
