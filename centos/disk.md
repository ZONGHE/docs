硬盘挂载
mount /dev/sda1 /data
重启自动挂载
echo "/dev/sda1 /data ext4 defaults 0 0" >> /etc/fstab

