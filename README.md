# Swap File Auto Setup Script

这个脚本可以帮助你一键创建、启用并配置 Linux 系统的交换文件（Swap），并支持自动备份 `/etc/fstab`，保证系统安全。

## 特性 Features

- 自定义指定大小 swap 文件（默认 1G）
- 自动将 swap 写入 `/etc/fstab` 实现开机自动挂载
- 自动备份 `/etc/fstab` 防止误操作

### 1. 下载脚本

```
wget https://raw.githubusercontent.com/coco-coc/swap-script/refs/heads/main/swap.sh
```
### 2. 给脚本加执行权限
```
chmod +x swap.sh
```
### 3. 运行脚本
```
./swap.sh
```

###  卸载脚本

### 1. 下载卸载脚本
```
wget https://raw.githubusercontent.com/coco-coc/swap-script/refs/heads/main/remove_swap.sh
```
### 2. 给脚本权限
```
chmod +x remove_swap.sh
```
### 3. 运行脚本
```
./remove_swap.sh
```
