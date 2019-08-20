# http://www.infonook.org/centos-bumblebee-nvidia/

# CentOS 7(1708) Intel+Nvidia双显卡笔记本安装Nvidia驱动并用Bumblebee控制独显


# Follow the step from http://elrepo.org/tiki/tiki-index.php
# Add ELRepo

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org (external link)

# Cent OS 7

yum install https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm (external link)

# Detect GPU Hardware
sudo yum install nvidia-detect

nvidia-detect -v

# Update Kernel
sudo yum update kernel kernel-devel

# Check if it's nouveau driver
lsmod |grep nouveau

# 禁用nouveau驱动
# 我们想要顺利安装nvidia驱动，那么必须先禁用nouveau驱动，还需要把它踢进黑名单中。

# 用文本编辑器打开 /lib/modprobe.d/dist-blacklist.conf 这个文件，在其中加入nouveau：

# blacklist nouveau options nouveau modeset=0

# 更改并重新生成grub2
# 用文本编辑器打开 /etc/default/grub 文件，在其中的：

# GRUB_CMDLINE_LINUX=”rd.lvm.lv=vg_centos/lv_root rd.lvm.lv=vg_centos/lv_swap rhgb quiet”

# quiet后面加入rdblacklist=nouveau ，保存。

# 打开终端，执行：

# sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# 重建initramfs image
# 我们首先把现有的移动到其它路径下以作为留手备份：

# 打开终端执行：

# sudo mv /boot/initramfs-$(uname -r).img /你喜欢的路径

# 然后重建它，执行：

# sudo dracut /boot/initramfs-$(uname -r).img $(uname -r)

# 即可。

# 设置启动方式为文本模式
# 因为我们需要执行显卡驱动的安装，所以不能进入图形界面。

# 打开终端，执行：

# systemctl set-default multi-user.target

# 然后reboot就行了。

# 查看nouveau是否被禁用
# 重启后会直接进入文本模式，需要用用户名和密码登陆一下终端。

# 然后执行：

# lsmod|grep nouveau

# 如果没有输出，那么就证明已经禁用了。

# 安装nvidia驱动
# 如果是比较新的显卡，比如9xx，那么直接执行：

# sudo yum install kmod-nvidia

# 即可。

# 如果不是比较新的，那么需要按照nnvidia-detect -v 命令所输出的版本进行安装。

# 到此，nvidia显卡驱动安装结束。

# Bumblebee的安装及配置
# 首先，你应该知晓这是一个什么东西，做什么用的，为什么选用它。

# 你首先需要去archlinux的wiki中了解以下bumblebee的相关知识，下面是链接：

# https://wiki.archlinux.org/index.php/bumblebee

# Bumblebee的安装
# 终端中执行：

# sudo yum install bumblebee

# 即可。

# 添加用户到Bumblebee的组
# 这一步可能并不是必要的，但如果安装后/重启后发现并没有自动把用户加入Bumblebee组中，那么需要执行：

# usermod -a uname -G bumblebee

# 这样就添加完成了。

# 配置Bumblebee 及 将控制面板加入用户菜单
# 不要盲目复制任何网络上的配置文件，请认真阅读注释及根据自身情况进行配置文档书写。

# 配置文档的配置，你可以根据：http://elrepo.org/tiki/bumblebee 此处的配置进行参考配置。

# 切回图形模式默认启动
# 终端执行：

# systemctl set-default graphical.target

# 重启即可。

# 至此，所有步骤完成，已可正常使用。

# 注：对于所有命令中不理解的地方请自行查阅资料，本文是以长期使用linux作为工作环境的使用者角度书写，很多基础知识不予赘述。