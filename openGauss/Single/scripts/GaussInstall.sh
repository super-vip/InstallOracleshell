MY_SOFTWARE_DIRECTORY=/soft/openGauss                                                                                       ## 软件包所在目录
MY_XML=/soft/openGauss/clusterconfig.xml                                                                                    ## 集群配置文件XML
openGauss_Download_url=https://opengauss.obs.cn-south-1.myhuaweicloud.com/2.0.1/x86/openGauss-2.0.1-CentOS-64bit-all.tar.gz ## openGauss软件包下载地址

## config hosts
cat <<EOF>/etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
$PUBLIC_IP $HOSTNAME
EOF
cat /etc/hosts
echo -e "\n"

## Download OpenGauss Software
mkdir -p $MY_SOFTWARE_DIRECTORY
cd $MY_SOFTWARE_DIRECTORY
wget $openGauss_Download_url
tar -zxvf *all.tar.gz
tar -zxvf *om.tar.gz
chmod -R 777 $MY_SOFTWARE_DIRECTORY/../
ls -ll
echo -e "\n"

## Configure XML
cat <<EOF>$MY_XML
<?xml version="1.0" encoding="UTF-8"?> 
<ROOT> 
    <!-- openGauss整体信息 --> 
    <CLUSTER> 
        <PARAM name="clusterName" value="dbCluster" /> 
        <PARAM name="nodeNames" value="$HOSTNAME" /> 
        <PARAM name="backIp1s" value="$PUBLIC_IP"/> 
        <PARAM name="gaussdbAppPath" value="$ENV_BASE_DIR/app" /> 
        <PARAM name="gaussdbLogPath" value="$ENV_BASE_DIR/log" /> 
        <PARAM name="gaussdbToolPath" value="$ENV_BASE_DIR/om" /> 
        <PARAM name="corePath" value="$ENV_BASE_DIR/corefile"/> 
        <PARAM name="clusterType" value="single-inst"/> 
    </CLUSTER> 
    <!-- 每台服务器上的节点部署信息 --> 
    <DEVICELIST> 
        <!-- node1上的节点部署信息 --> 
        <DEVICE sn="1000001"> 
            <PARAM name="name" value="$HOSTNAME"/> 
            <PARAM name="azName" value="AZ1"/> 
            <PARAM name="azPriority" value="1"/> 
            <!-- 如果服务器只有一个网卡可用，将backIP1和sshIP1配置成同一个IP --> 
            <PARAM name="backIp1" value="$PUBLIC_IP"/> 
            <PARAM name="sshIp1" value="$PUBLIC_IP"/> 
             
        <!--dbnode--> 
        <PARAM name="dataNum" value="1"/> 
        <PARAM name="dataPortBase" value="26000"/> 
        <PARAM name="dataNode1" value="$ENV_BASE_DIR/data/db1"/> 
        </DEVICE> 
    </DEVICELIST> 
</ROOT>
EOF

cat $MY_XML
echo -e "\n"

cat <<OGI>/soft/og_install.sh
# Begin to execute openGauss preinstall
#python $MY_SOFTWARE_DIRECTORY/script/gs_preinstall -U omm -G dbgrp -X $MY_XML --non-interactive
python $MY_SOFTWARE_DIRECTORY/script/gs_preinstall -U omm -G dbgrp -X $MY_XML

## 检查预安装环境
$MY_SOFTWARE_DIRECTORY/script/gs_checkos -i A -h $HOSTNAME --detail

## Begin to execute openGauss install
cat <<EOF >/home/omm/install_db
source ~/.bashrc
gs_install -X  $MY_XML --gsinit-parameter="--encoding=UTF8" --dn-guc="max_process_memory=3GB" --dn-guc="shared_buffers=128MB" --dn-guc="cstore_buffers=16MB"
EOF
chown -R omm:dbgrp /home/omm/install_db
su - omm -c "sh /home/omm/install_db"

cat <<EOF>>/home/omm/.bash_profile
alias gs='gsql -d postgres -p 26000 -r'
export PS1="[\`whoami\`@\`hostname\`:"'\$PWD]\$ '
EOF
OGI
