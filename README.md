# Shell-InstallOracle

使用 ShellScripts 脚本安全快速安装 Oracle 数据库！**提高生产力，释放劳动力！**

![](https://oss-emcsprod-public.modb.pro/image/editor/20210820-e2383132-4d88-40e5-994c-fc7de60a8792.png)

## 背景

**为什么要写这个项目？**

- 首先，安装 Oracle 数据库是一件极为复杂且枯燥的任务；
- 常规的操作方式往往是基于文档，博客，视频等教程方式，按部就班的执行安装步骤，耗时费力，且极为容易因为粗心导致各种各样的问题产生；
- 于是，我想到可以编写一个基于标准流程的 Shell 脚本来进行安装，因为只要代码没有错误，机器是不会出错的；
- 经过大量时间的编写和测试，目前已可以用于生产环境安装部署。

**项目支持哪些平台安装？**

- 本项目仅支持 `Linux64 6/7/8` 平台：`Centos`、`Redhat`、`OracleLinux`。
- 支持大部分主流 `Oracle` 版本： `11GR2`、`12CR2`、`18C`、`19C`、`21C`。
- 支持数据库安装模式：`单机`、`单机ASM`、`RAC集群`。

## 下载

使用此项目之前，需要先从此下载项目：

```sh
$ git clone https://github.com/pc-study/InstallOracleshell.git
```

## 使用说明

本项目使用方式分为`新手纯享版本`和`高手进阶版本`，平时学习测试建议使用新手纯享版本即可。

### 新手纯享版本

新手纯享版本基本不需要基础，目前仅支持 **单机模式** 安装！必须使用 [vagrant](https://www.vagrantup.com/downloads) 和 [virtualbox](https://www.virtualbox.org/wiki/Downloads)，请确保你本地安装了它们。

- **第一步，上传 Oracle 安装包：**

进入项目目录 `InstallOracleshell/single_db/software` 下，可以看到有不同 `Oracle` 版本目录，其中有一个 `software.txt` 文件，内容为你需要上传的 `oracle` 安装包。

```shell
├── 11204
│   ├── p13390677_112040_Linux-x86-64_1of7.zip
│   └── p13390677_112040_Linux-x86-64_2of7.zip
├── 12201
│   └── LINUX.X64_122010_db_home.zip
├── 18000
│   └── LINUX.X64_180000_db_home.zip
├── 19300
│   └── LINUX.X64_193000_db_home.zip
├── 21300
│   └── LINUX.X64_213000_db_home.zip
```

确认你需要安装的 `Oracle` 版本，拷贝 `Oracle` 安装包到对应目录下，**确保安装包名称与以下名称相同，否则安装<font color='red'>失败</font>！**

- **第二步，编辑 vagrant.yml 配置文件：**

进入项目目录 `InstallOracleshell/single_db/config` 下，打开 `vagrant.yml` 文件：

```
box: luciferliu/centos7.9
vm_name: orcl
hostname: orcl
mem_size: 2048
cpus: 2
public_ip: 192.168.56.100
non_rotational: 'on'
db_version: 11
db_patch:
oracle_password: oracle
oracle_sid: orcl
install_base: /u01/app
characterset: AL32UTF8
cdb: true
pdb: pdb01
```

**参数介绍：**
```
box             	: Linux 主机版本，19c 和 21c 版本不支持 linux 6 版本！
可选值：
- luciferliu/centos6.10
- luciferliu/centos7.9
- luciferliu/centos8.3
- luciferliu/oraclelinux6.10
- luciferliu/oraclelinux7.9
- luciferliu/oraclelinux8.3
vm_name         	: 虚拟机名称，随意修改，默认即可。
hostname        	: 主机名称，随意修改，默认即可。
mem_size        	: 内存大小，单位是 `MiB`，根据需要修改，正常默认即可。
cpus            	: cpu 个数，根据需要修改，正常默认即可。
public_ip       	: IP 地址，根据网卡定义修改，正常默认即可。
non_rotational    : 不用修改值，默认即可。
db_version      	: oracle 数据库版本，根据实际情况填写！
db_patch        	: PSU/RU 补丁号，根据需要填写，不打补丁可以不填。
oracle_password   : oracle 用户密码，默认即可。
oracle_sid      	: oracle 数据库实例名，默认即可。
install_base      : oracle 安装根目录，默认即可。
characterset      : 数据库字符集，根据实际需要填写，正常默认即可。
cdb             	: CDB 模式需要填写 true。
pdb             	: PDB 名称，开启 CDB 模式后才可生效。
```

根据实际情况修改脚本，默认不修改将安装 `Oracle 11GR2` 数据库。

- **第三步，执行 `vagrant up` 安装：**

回到 `InstallOracleshell/single_db` 目录下，执行 `vagrant up` 开始安装。

**📢 注意：** `InstallOracleshell/single_db/software` 目录中的 `OracleShellInstall.sh` 脚本需要保持最新，最新版本脚本在上层目录 `InstallOracleshell` 下。

- **第四步，等待自动安装成功后，连接主机：**

这里有三种方式来连接主机：

1、使用 `ssh root@192.168.56.100` 来连接，`root` 用户密码是 `oracle` ，使用 `Xshell` 等连接工具也可连接；

2、使用 `vagrant ssh` 来连接，注意要在 `InstallOracleshell/single_db` 目录下执行，连接进去是 `vagrant` 用户，使用 `su - oracle` 来切换即可。

3、使用 `Virtualbox` 虚拟机直接打开访问。

- **第五步，关闭主机：**

1、在主机中，执行 `init 0` 等关机命令关闭主机。

2、使用 `Virtualbox` 虚拟机右键关闭。

3、进入  `InstallOracleshell/single_db` 目录下执行 `vagrant halt` 关闭。

- **最后**

用完了，不需要使用了怎么办？

1、直接打开 `Virtualbox` 虚拟机，右键删除。

2、进入  `InstallOracleshell/single_db` 目录下执行 `vagrant destory` 销毁它。

### 高手进阶版本

正常来说，平时学习测试使用 `新手纯享版本` 完全够了，但是如果你想使用在 `生产环境` ，那你必须得学会 `高手进阶版本` ！真正提高生产力~

既然看到这的说明都是高手，那就长话短说，这个项目你只需要下载这一个脚本 `OracleShellInstall.sh` 就够了！

脚本有了，具体如何使用？

![](https://img-blog.csdnimg.cn/20210603100942949.png?" style="float:left;" )

**📢 前提：** 提前安装 Linux 系统，上传安装介质，挂载 ISO 镜像。

### 单机

- **第一步，手动安装 Linux 系统，配置网络，挂载 ISO 镜像；**

- **第二步，创建 /soft 目录，上传安装介质；**

- **第三步，编辑脚本安装命令，填写关键信息：**

`最简安装` 脚本示例：

```shell
./OracleShellInstall.sh -i 192.168.56.155
```

`单机自定义` 脚本命令示例：

```shell
./OracleShellInstall.sh -i 192.168.56.155 `#Public ip`\
-n topdbdev `# hostname`\
-o topstd `# oraclesid`\
-c TRUE `# ISCDB`\
-pb pdb01 `# PDBNAME`\
-rs oracle `# root password`\
-op oracle `# oracle password`\
-gp oracle `# grid password`\
-b /u01/app `# install basedir`\
-s AL32UTF8 `# characterset`\
-ns UTF8 `# national characterset`
```

关于参数解释以及配置，点击 [参数README]() 跳转。

- **第四步，`root` 用户下进入 `/soft` 目录下执行脚本安装命令；**

- **第五步，等待安装过程中，可以进入 `/soft` 目录中查看安装部署日志，安装结束后重启主机；**
- **第六步，检查数据库运行情况。**

脚本中所有操作均为静默连续执行，敲下命令之后无需任何操作，等待安装成功即可。

### 单机ASM

`单机ASM` 脚本命令示例：

```shell
./OracleShellInstall.sh -i 192.168.56.155 `#Public ip`\
-n topdbdev `# hostname`\
-o topstd `# oraclesid`\
-rs oracle `# root password`\
-op oracle `# oracle password`\
-gp oracle `# grid password`\
-b /u01/app `# install basedir`\
-s AL32UTF8 `# characterset`\
-ns UTF8 `# national characterset`\
-dd /dev/sde `# asm data disk`\
-dn DATA `# asm data diskgroupname`\
-dr EXTERNAL `# asm data redundancy`\
-gpa 31718723 `# Grid PSU NUMBER`
```

关于参数解释以及配置，点击 [参数README]() 跳转。

### RAC

这里我简单说下在生产环境使用脚本部署 `	RAC` 的大概步骤：

- **第一步，手动安装两台 Linux 主机；**
- **第二步，分别配置网络，挂载 iso 镜像源，挂载共享存储；**

- **第三步，节点一创建 /soft 目录并上传安装介质；**

- **第四步，编辑脚本安装命令，填写两台主机的关键信息；**

`RAC` 脚本命令示例：

```shell
./OracleShellInstall.sh -i 192.168.56.151 `# node1 Public ip`\
-n topdb `# rac hostname`\
-o TOPDB `# oraclesid`\
-rs oracle `# root password`\
-op oracle `# oracle password`\
-gp oracle `# grid password`\
-b /u01/app `# install basedir`\
-s AL32UTF8 `# characterset`\
-ns UTF8 `# national characterset`\
-pb1 192.168.56.151 -pb2 192.168.56.153 `# node public ip`\
-vi1 192.168.56.152 -vi2 192.168.56.154 `# node virtual ip`\
-pi1 10.10.10.11 -pi2 10.10.10.12 `# node private ip`\
-pi3 10.10.11.11 -pi4 10.10.11.12 `# node private1 ip`\
-si 192.168.56.150 `# scan ip`\
-od /dev/sdb,/dev/sdc,/dev/sdd `# asm ocr disk`\
-dd /dev/sde `# asm data disk`\
-on OCR `# asm ocr diskgroupname`\
-dn DATA `# asm data diskgroupname`\
-or NORMAL `# asm ocr redundancy`\
-dr EXTERNAL `# asm data redundancy`\
-puf team0 -prf em3 -prf1 em4 `# network fcname`\
-tsi 192.168.56.252 `# timeserver`\
-gpa 31718723 `# Grid PSU NUMBER`
```

关于参数解释以及配置，点击 [参数README]() 跳转。

- **第五步，节点一 `root` 用户下进入 `/soft` 目录下执行脚本安装命令；**

- **第六步，等待安装过程中，可以进入 `/soft` 目录中查看安装部署日志，安装结束后重启两台主机；**
- **第七步，检查两台主机数据库运行情况。**

脚本中所有操作均为静默连续执行，敲下命令之后无需任何操作，等待安装成功即可。

## 脚本参数

关于参数解释以及配置，点击 [参数README]() 跳转。

## 徽章
如果你的项目遵循 Shell-InstallOracle 而且项目位于 Github 上，非常希望你能把这个徽章加入你的项目。它可以更多的人访问到这个项目，而且采纳 Shell-InstallOracle。 加入徽章**并非强制的**。 

[![](https://img.shields.io/badge/license-MIT-blue)](https://opensource.org/licenses/mit-license.php) [![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme) [![](https://img.shields.io/badge/Shell-Oracle-ff69b4?style=plastic&logo=appveyor)](https://github.com/pc-study/InstallOracleshell) [![](https://img.shields.io/badge/vagrant-oracle-orange?style=plastic&logo=appveyor)](https://github.com/pc-study/InstallOracleshell) [![](https://img.shields.io/badge/Oracle-11RG2-blue)](https://github.com/pc-study/InstallOracleshell) [![](https://img.shields.io/badge/Oracle-12CR2-blue)](https://github.com/pc-study/InstallOracleshell) [![](https://img.shields.io/badge/Oracle-18C-blue)](https://github.com/pc-study/InstallOracleshell) [![](https://img.shields.io/badge/Oracle-19C-blue)](https://github.com/pc-study/InstallOracleshell) [![](https://img.shields.io/badge/Oracle-21C-blue)](https://github.com/pc-study/InstallOracleshell)

❤️ **欢迎 👏🏻 关注作者！**❤️

[![](https://img.shields.io/badge/%E5%BE%AE%E4%BF%A1%E5%85%AC%E4%BC%97%E5%8F%B7-Lucifer%E4%B8%89%E6%80%9D%E8%80%8C%E5%90%8E%E8%A1%8C-red)](https://mp.weixin.qq.com/s/mNtdtnNpjfXjpkB6jkoZUQ) [![](https://img.shields.io/badge/CSDN-Lucifer%E4%B8%89%E6%80%9D%E8%80%8C%E5%90%8E%E8%A1%8C-orange)](https://luciferliu.blog.csdn.net/)

为了加入徽章到 Markdown 文本里面，可以使用以下代码：

```
[![standard-readme compliant](https://img.shields.io/badge/Shell-Oracle-ff69b4?style=plastic&logo=appveyor)](https://github.com/pc-study/InstallOracleshell)
```

## 相关仓库

- [Vagrant Builds](https://github.com/oraclebase/vagrant) — OracleBase Install Oracle By Vagrant。
- [Bento](https://github.com/chef/bento) — Provide [Packer](https://www.packer.io/) templates for building [Vagrant](https://www.vagrantup.com/) base boxes。

## 维护者

[@pc-study](https://github.com/pc-study/InstallOracleshell)

## 如何贡献

非常欢迎你的加入！[提一个 Issue](https://github.com/pc-study/InstallOracleshell/issues/new) 或者提交一个 Pull Request。

**❤️创作不易，觉得好的可以请我喝杯奶茶🧋哈！**

<img src="https://oss-emcsprod-public.modb.pro/image/editor/20210820-4257a655-756a-4a53-8a3f-6e8de333da81.png?" style="zoom:48%;float:left" />


## 使用许可

[MIT](LICENSE) © Lucifer三思而后行
