#!/bin/bash

##Configure Linux environment For openGauss
echo opengauss | passwd --stdin root
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo "Red Hat Enterprise Linux Server release 7.6 (Maipo)" >/etc/redhat-release
## 1.Disable firewalld service
systemctl disable firewalld.service
systemctl stop firewalld.service
echo "Firewalld " `systemctl status firewalld|grep Active`
echo "1.Disable firewalld service completed."
echo -e "\n"

## 2.Disable SELINUX
sed -i '/^SELINUX=/d' /etc/selinux/config
echo "SELINUX=disabled" >> /etc/selinux/config
cat /etc/selinux/config|grep "SELINUX=disabled"
echo "2.Disable SELINUX completed."
echo -e "\n"


## 3.Configure encoding
echo "LANG=en_US.UTF-8" >> /etc/profile
source /etc/profile
echo $LANG
echo "3.Configure encoding completed."
echo -e "\n"

## 4. Configure Timezone
rm -fr /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
date -R
hwclock
echo "4.Configure Timezone completed."
echo -e "\n"

## 5. Turn off SWAP
sed -i '/swap/s/^/#/' /etc/fstab
swapoff -a
free -m
echo "5.Close swap partition completed."
echo -e "\n"

## optional options,please take care of this
## echo "MTU=8192" >>  /etc/sysconfig/network-scripts/ifcfg-ens34
## For 10GB Ethernet environment , please set rx = 4096、tx = 4096

## 6. Configure SSH Service 
sed -i '/Banner/s/^/#/'  /etc/ssh/sshd_config
sed -i '/PermitRootLogin/s/^/#/'  /etc/ssh/sshd_config
echo -e "\n" >> /etc/ssh/sshd_config
echo "Banner none " >> /etc/ssh/sshd_config
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
cat /etc/ssh/sshd_config |grep -v ^#|grep -E 'PermitRoot|Banner'
echo "6.Configure SSH Service completed."
echo -e "\n"

## 7. Configure YUM and Install Packages
yum install -y wget
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo  /etc/yum.repos.d/bak/
wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo
yum clean all
yum install -y bzip2 python3
yum install -y libaio-devel flex bison ncurses-devel glibc-devel patch redhat-lsb-core readline-devel
mv /usr/bin/python /usr/bin/python2_bak
ln -s /usr/bin/python3 /usr/bin/python
## 修复python3 link之后无法使用yum
sed -i 's/\/bin\/python/\/bin\/python2/g' /bin/yum
sed -i 's/\/bin\/python/\/bin\/python2/g' /usr/libexec/urlgrabber-ext-down
echo "7.Configure YUM and Install Packages completed."
echo -e "\n"

## 8. Close transparent_hugepage
################Only for CentOS [Close transparent_hugepage]#####################
# cat >>/etc/rc.d/rc.local<<EOF
# if test -f /sys/kernel/mm/transparent_hugepage/enabled; then
#    echo never > /sys/kernel/mm/transparent_hugepage/enabled
# fi
# if test -f /sys/kernel/mm/transparent_hugepage/defrag; then
#    echo never > /sys/kernel/mm/transparent_hugepage/defrag
# fi
# EOF
# chmod +x /etc/rc.d/rc.local
sed -i 's/quiet/quiet transparent_hugepage=never/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
echo "8.Close transparent_hugepage completed."
echo -e "\n"
################################################################################

## 9. Configure OS Parameter
cat >> /etc/sysctl.conf <<EOF
net.ipv4.tcp_retries1 = 5
net.ipv4.tcp_syn_retries = 5
net.sctp.path_max_retrans = 10
net.sctp.max_init_retransmits = 10
EOF
#net.sctp.path_max_retrans = 10
#net.sctp.max_init_retransmits = 10
################Only for openEuler[Disable RemoveIPC]#####################
## sed -i '/^RemoveIPC/d' /etc/systemd/logind.conf
## sed -i '/^RemoveIPC/d' /usr/lib/systemd/system/systemd-logind.service
## echo "RemoveIPC=no"  >> /etc/systemd/logind.conf
## echo "RemoveIPC=no"  >> /usr/lib/systemd/system/systemd-logind.service
## systemctl daemon-reload
## systemctl restart systemd-logind
## loginctl show-session | grep RemoveIPC
## systemctl show systemd-logind | grep RemoveIPC
## echo "10.Disable RemoveIPC completed."
## echo -e "\n"
## echo -e "\n"
##########################################################################