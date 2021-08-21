mkdir /soft
RELS=$(cat /etc/system-release)
OS_VER_PRI=$(echo "${RELS#*release}" | awk '{print $1}' | cut -f 1 -d '.')
if [ "${OS_VER_PRI}" -eq 6 ]; then
    service sshd restart
elif [ "${OS_VER_PRI}" -eq 7 ] || [ "${OS_VER_PRI}" -eq 8 ]; then
    systemctl restart sshd
fi
cp /vagrant/OracleShellInstall.sh /soft
cp /vagrant/compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm /soft
cp /vagrant/rlwrap* /soft
chmod +x /soft/OracleShellInstall.sh
cd /soft
if [ $DB_VERSION = "11" ] || [ $DB_VERSION = "11g" ] || [ $DB_VERSION = "11G" ]; then
  cp /vagrant/11204/* /soft
  if [ -z $DB_PATCH ]; then
    ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
  else
    ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
  fi
elif [ $DB_VERSION = "12" ] || [ $DB_VERSION = "12c" ] || [ $DB_VERSION = "12C" ]; then
  cp /vagrant/12201/* /soft
  if [ $CDB = "true" ]; then
    if [ -z $PDB ]; then
      if [ -z $DB_PATCH ]; then
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
      else
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
      fi
    else
      if [ -z $DB_PATCH ]; then
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
      else
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
      fi
    fi
  else
    if [ -z $DB_PATCH ]; then
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
    else
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
    fi
  fi
elif [ $DB_VERSION = "18" ] || [ $DB_VERSION = "18c" ] || [ $DB_VERSION = "18C" ]; then
  cp /vagrant/18000/* /soft
  if [ $CDB = "true" ]; then
    if [ -z $PDB ]; then
      if [ -z $DB_PATCH ]; then
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
      else
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
      fi
    else
      if [ -z $DB_PATCH ]; then
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
      else
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
      fi
    fi
  else
    if [ -z $DB_PATCH ]; then
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
    else
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
    fi
  fi
elif [ $DB_VERSION = "19" ] || [ $DB_VERSION = "19c" ] || [ $DB_VERSION = "19C" ]; then
  cp /vagrant/19300/* /soft
  if [ $CDB = "true" ]; then
    if [ -z $PDB ]; then
      if [ -z $DB_PATCH ]; then
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
      else
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
      fi
    else
      if [ -z $DB_PATCH ]; then
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
      else
        ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
      fi
    fi
  else
    if [ -z $DB_PATCH ]; then
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
    else
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
    fi
  fi
elif [ $DB_VERSION = "21" ] || [ $DB_VERSION = "21c" ] || [ $DB_VERSION = "21C" ]; then
  cp /vagrant/21300/* /soft
  if [ -z $PDB ]; then
    if [ -z $DB_PATCH ]; then
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
    else
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
    fi
  else
    if [ -z $DB_PATCH ]; then
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -installmode single -dbv $DB_VERSION -iso N
    else
      ./OracleShellInstall.sh -i $PUBLIC_IP -n $HOSTNAME -o $ORACLE_SID -c TRUE -pb $PDB -op $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -opa $DB_PATCH -installmode single -dbv $DB_VERSION -iso N
    fi
  fi
else
  echo "db_version is invalid! Please set 11/12/18/19/21!"
  exit 99
fi

