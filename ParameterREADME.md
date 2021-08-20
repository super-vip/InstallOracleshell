##  参数介绍
- **本脚本通过参数来预配置脚本命令，可通过帮助命令来查看有哪些参数：**

> 执行 `./OracleShellInstall --help` 可以查看参数。

参数详解：

- **`-i`  全称 PUBLICIP：当前主机用于访问的IP，<font color='red'>必填参数</font>。**

> 使用方式：`-i 10.211.55.100`
- **`-n` 全称 HOSTNAME：当前主机的主机名，默认值为 orcl。**

> 使用方式：`-n orcl`
> 
如果选择rac模式，节点1、2主机名自动取为：orcl1、orcl2。
- **`-o` 全称 ORACLE_SID：Oracle实例名称，默认值为 orcl。**

> 使用方式：`-o orcl`

- **`-c` 全称 ISCDB：判断是否为CDB模式，11GR2不支持该参数，默认值为FALSE。**

> 使用方式：`-c TRUE`

- **`-pb` 全称 PDBNAME：创建PDB的名称，11GR2不支持该参数。**

> 使用方式：`-pb pdb01`

- **`-op` 全称 ORAPASSWD：oracle用户的密码，默认值为oracle。**

> 使用方式：`-op oracle`

- **`-b` 全称 ENV_BASE_DIR：Oracle基础安装目录，默认值为/u01/app。**

> 使用方式：`-b /u01/app`

- **`-s` 全称 CHARACTERSET：Oracle数据库字符集，默认值为AL32UTF8。**

> 使用方式：`-s AL32UTF8`

**<font color='blue'>以下为RAC模式安装的参数：</font>**

- **`-rs` 全称 ROOTPASSWD：root用户的密码，默认值为oracle。**

> 使用方式：`-rs oracle`

- **`-gp` 全称 GRIDPASSWD：grid用户的密码，默认值为oracle。**

> 使用方式：`-gp oracle`

- **`-pb1` 全称 RAC1PUBLICIP：节点一的主机访问IP，<font color='red'>必填参数</font>。**

> 使用方式：`-pb1 10.211.55.100`

- **`-pb2` 全称 RAC2PUBLICIP：节点二的主机访问IP，<font color='red'>必填参数</font>。**

> 使用方式：`-pb2 10.211.55.101`

- **`-vi1` 全称 RAC1VIP：节点一的主机虚拟IP，<font color='red'>必填参数</font>，与主机访问IP网段必须相同。**

> 使用方式：`-vi1 10.211.55.102`

- **`-vi2` 全称 RAC2VIP：节点二的主机虚拟IP，<font color='red'>必填参数</font> ，与主机访问IP网段必须相同。**

> 使用方式：`-vi2 10.211.55.103`

- **`-pi1` 全称 ：RAC1PRIVIP，节点一的主机私有IP，<font color='red'>必填参数</font> ，可凭借喜好进行自定义。**

> 使用方式：`-pi1 10.10.1.1`

- **`-pi2` 全称 ：RAC2PRIVIP，节点二的主机私有IP，<font color='red'>必填参数</font>，可凭借喜好进行自定义。**

> 使用方式：`-pi2 10.10.1.2`

- **`-pi3` 全称 ：RAC1PRIVIP1，节点一的第二个主机私有IP，<font color='blue'>可选参数</font> ，可凭借喜好进行自定义。**

> 使用方式：`-pi3 1.1.1.1`

- **`-pi4` 全称 ：RAC2PRIVIP1，节点二的第二个主机私有IP，<font color='blue'>可选参数</font> ，可凭借喜好进行自定义。**

> 使用方式：`-pi4 1.1.1.2`

- **`-puf` 全称 ：RACPUBLICFCNAME，主机的访问IP对应的网卡名称，<font color='red'>必填参数</font> ，节点1，2必须名称一致。**

> 使用方式：`-puf eth0`

- **`-prf` 全称 RACPRIVFCNAME：主机的私有IP对应的网卡名称，<font color='red'>必填参数</font> ，节点1，2必须名称一致。**

> 使用方式：`-prf eth1`

- **`-prf1` 全称 RACPRIVFCNAME1：主机的第二私有IP对应的网卡名称，<font color='blue'>可选参数</font> ，节点1，2必须名称一致。**

> 使用方式：`-prf1 eth2`

- **`-si` 全称 RACSCANIP：主机的SCANIP，<font color='red'>必填参数</font> ，与主机访问IP网段必须相同。当配置DNS解析时，最多可支持填写3个IP，通过逗号隔开。**

> 使用方式：`-si 10.211.55.104,10.211.55.105,10.211.55.106`

- **`-dn` 全称 ASMDATANAME：ASM数据盘名称，默认值为DATA。**

> 使用方式：`-dn DATA`

- **`-on` 全称 ASMOCRNAME：ASM裁决盘名称，默认值为OCR。**

> 使用方式：`-on OCR`

- **`-dd` 全称 DATA_BASEDISK：数据盘对应的磁盘名称，<font color='red'>必填参数</font> 。支持多块磁盘填写，用逗号隔开。**

> 使用方式：`-dd /dev/sdb,/dev/sdc,/dev/sdd`

- **`-od` 全称 OCR_BASEDISK：裁决盘对应的磁盘名称，<font color='red'>必填参数</font> 。支持多块磁盘填写，用逗号隔开。**

> 使用方式：`-od /dev/sde,/dev/sdf`

- **`-or` 全称 OCRREDUN：裁决盘的冗余选项，默认值为EXTERNAL。<font color='blue'>冗余选项EXTERNAL、NORMAL、HIGH对应磁盘最小数量为1、3、5。</font>**

> 使用方式：`-or EXTERNAL`

- **`-dr` 全称 OCRREDUN：裁决盘的冗余选项，默认值为EXTERNAL。<font color='blue'>冗余选项EXTERNAL、NORMAL、HIGH对应磁盘最小数量为1、2、3。</font>**

> 使用方式：`-dr EXTERNAL`

- **`-tsi` 全称 TIMESERVERIP：时间同步服务器IP，<font color='blue'>可选参数</font> ，根据实际情况进行填写。**

> 使用方式：`-tsi 10.211.55.200`

- **`-txh` 全称 TuXingHua：图形化界面安装，默认值为N。选择Y后将安装图形化界面所需依赖。**

> 使用方式：`-txh Y`

- **`-udev` 全称 UDEV：自动配置multipath+UDEV绑盘，默认值为Y。**

> 使用方式：`-udev Y`

**<font color='blue'>以下参数为配置DNS解析：</font>**

- **`-dns` 全称 DNS：配置DNS解析，默认值为N。**

> 使用方式：`-dns N`

- **`-dnss` 全称 DNSSERVER：当前主机配置为DNS服务器，默认值为N。前提是 `-dns Y` 才生效。**

> 使用方式：`-dnss N`

- **`-dnsn` 全称 DNSNAME：DNS服务器的解析名称，前提是 `-dns Y` 才生效。**

> 使用方式：`-dnsn orcl.com`

- **`-dnsi` 全称 DNSIP：DNS服务器的IP，前提是 `-dns Y` 才生效。**

> 使用方式：`-dnsi 10.211.55.200`

- **`-m` 全称 ONLYCONFIGOS：仅配置操作系统参数，默认值为N。值为Y时，脚本只执行到操作系统配置完成就结束，不会进行安装，通常可用于图形化安装的初始化。**

> 使用方式：`-m Y`

- **`-g` 全称 ONLYINSTALLGRID：仅安装Grid软件，默认值为N。**

> 使用方式：`-g Y`

- **`-w` 全称 ONLYINSTALLORACLE：仅安装Oracle软件，默认值为N。**

> 使用方式：`-w Y`

- **`-ocd` 全称 ONLYCREATEDB：仅创建Oracle数据库实例，默认值为N。**

> 使用方式：`-ocd Y`

- **`-gpa` 全称 GRID RELEASE UPDATE：Grid软件的PSU或者RU补丁的补丁号。**

> 使用方式：`-gpa 32072711`

- **`-opa` 全称 ORACLE RELEASE UPDATE：Oracle软件的PSU或者RU补丁的补丁号。**

> 使用方式：`-opa 32072711`

