mkdir /soft
RELS=$(cat /etc/system-release)
OS_VER_PRI=$(echo "${RELS#*release}" | awk '{print $1}' | cut -f 1 -d '.')

cp /vagrant/compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm /soft
cp /vagrant/OracleShellInstall.sh /soft
cp /vagrant/rlwrap* /soft
chmod +x /soft/OracleShellInstall.sh
cd /soft
if [ $DB_VERSION = "11" ] || [ $DB_VERSION = "11g" ] || [ $DB_VERSION = "11G" ]; then
  cp /vagrant/11204/* /soft
  if [ -z $GI_PATCH ]; then
    cat <<EOF>/soft/rac_install.sh
    ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
  else
    cat <<EOF>/soft/rac_install.sh
    ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
  fi
elif [ $DB_VERSION = "12" ] || [ $DB_VERSION = "12c" ] || [ $DB_VERSION = "12C" ]; then
  cp /vagrant/12201/* /soft
  if [ $CDB = "true" ]; then
    if [ -z $PDB ]; then
      if [ -z $GI_PATCH ]; then
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      else
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      fi
    else
      if [ -z $GI_PATCH ]; then
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      else
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      fi
    fi
  else
    if [ -z $GI_PATCH ]; then
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    else
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    fi
  fi
elif [ $DB_VERSION = "18" ] || [ $DB_VERSION = "18c" ] || [ $DB_VERSION = "18C" ]; then
  cp /vagrant/18000/* /soft
  if [ $CDB = "true" ]; then
    if [ -z $PDB ]; then
      if [ -z $GI_PATCH ]; then
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      else
      cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      fi
    else
      if [ -z $GI_PATCH ]; then
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      else
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      fi
    fi
  else
    if [ -z $GI_PATCH ]; then
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    else
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    fi
  fi
elif [ $DB_VERSION = "19" ] || [ $DB_VERSION = "19c" ] || [ $DB_VERSION = "19C" ]; then
  cp /vagrant/19300/* /soft
  if [ $CDB = "true" ]; then
    if [ -z $PDB ]; then
      if [ -z $GI_PATCH ]; then
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      else
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      fi
    else
      if [ -z $GI_PATCH ]; then
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      else
        cat <<EOF>/soft/rac_install.sh
        ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c $CDB -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
      fi
    fi
  else
    if [ -z $GI_PATCH ]; then
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    else
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    fi
  fi
elif [ $DB_VERSION = "21" ] || [ $DB_VERSION = "21c" ] || [ $DB_VERSION = "21C" ]; then
  cp /vagrant/21300/* /soft
  if [ -z $PDB ]; then
    if [ -z $GI_PATCH ]; then
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c TRUE -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    else
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c TRUE -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    fi
  else
    if [ -z $GI_PATCH ]; then
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c TRUE -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    else
      cat <<EOF>/soft/rac_install.sh
      ./OracleShellInstall.sh -i $PUBLIC_IP1 -n $PREFIX_NAME -o $ORACLE_SID -c TRUE -pb $PDB -rs oracle -op $GRID_PASSWORD -gp $ORACLE_PASSWORD -b $INSTALL_BASE -s $CHARACTERSET -pb1 $PUBLIC_IP1 -pb2 $PUBLIC_IP2 -vi1 $VIP_IP1 -vi2 $VIP_IP2 -pi1 $PRIV_IP1 -pi2 $PRIV_IP2 -si $SCAN_IP -od /dev/sdb -dd /dev/sdc -on OCR -dn DATA -or EXTERNAL -dr EXTERNAL -puf eth1 -prf eth2 -gpa $GI_PATCH -installmode rac -dbv $DB_VERSION -iso N -vbox Y
EOF
    fi
  fi
else
  echo "db_version is invalid! Please set 11/12/18/19/21!"
  exit 99
fi

