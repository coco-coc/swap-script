# Swap File Auto Setup Script

这个脚本可以帮助你一键创建、启用并配置 Linux 系统的交换文件（Swap），并支持自动备份 `/etc/fstab`，保证系统安全。

## 特性 Features

- 自动创建指定大小的 swap 文件（默认 1G）
- 自动设置权限和启用 swap
- 自动将 swap 写入 `/etc/fstab` 实现开机自动挂载
- 自动备份 `/etc/fstab` 防止误操作

### 1. 运行脚本

```
wget https://raw.githubusercontent.com/你的用户名/你的仓库名/main/create_swap.sh
chmod +x create_swap.sh
