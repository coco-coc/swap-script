#!/bin/bash

SWAPFILE="/swapfile"
FSTAB="/etc/fstab"
BACKUP="/etc/fstab.back"

# 交互式输入 Swap 大小，默认1G，格式校验（必须是数字+M或G）
while true; do
    read -p "请输入 Swap 大小（例如 512M、1G、8G，默认 1G）: " USER_SWAPSIZE
    USER_SWAPSIZE=${USER_SWAPSIZE:-1G}
    if [[ $USER_SWAPSIZE =~ ^[0-9]+[MG]$ ]]; then
        SWAPSIZE=$USER_SWAPSIZE
        break
    else
        echo "输入无效，请输入类似 512M 或 1G 的格式"
    fi
done

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
