#!/bin/bash 

export privateip=$1

export nodeid=$2

sudo apt-get update -y  

sudo apt-get upgrade -y
 
sudo apt-get -y install xfsprogs
 
sudo modprobe -v xfs 

sudo apt-get -y install gnupg 
 
wget https://www.beegfs.io/release/beegfs_7.2.3/dists/beegfs-deb10.list 
 
sudo cp beegfs-deb10.list /etc/apt/sources.list.d/ 
 
sudo wget -q https://www.beegfs.io/release/latest-stable/gpg/DEB-GPG-KEY-beegfs -O- | sudo apt-key add -
 
sudo apt update -y 

sudo apt-get -y install beegfs-mgmtd 
 
sudo mkdir /beegfs-mgmt 
 
sudo /opt/beegfs/sbin/beegfs-setup-mgmtd -p /beegfs-mgmt/beegfs/beegfs_mgmtd
  
sudo apt-get -y install beegfs-meta beegfs-storage beegfs-meta beegfs-client beegfs-helperd beegfs-utils

# Format and mount the first device as a metadata desk

mkfs -t ext4 /dev/nvme0n1
mkdir /desk0
mount /dev/nvme0n1 /desk0

# Format and mount all other available devices 

devices=( )

function add_device
{
    devices=( "${devices[@]}" $1 )
}

function check_device
{
    if [ -e /dev/$1 ]; then
        add_device $1
    fi
}

function check_devices
{
    check_device nvme1n1
    check_device nvme2n1
    check_device nvme3n1
    check_device nvme4n1
    check_device nvme5n1
    check_device nvme6n1
    check_device nvme7n1
    check_device nvme8n1
    check_device nvme9n1
    check_device nvme10n1
    check_device nvme11n1
    check_device nvme12n1
    check_device nvme13n1
    check_device nvme14n1
    check_device nvme15n1
    check_device nvme16n1
    check_device nvme17n1
    check_device nvme18n1
    check_device nvme19n1
    check_device nvme20n1
    check_device nvme21n1
    check_device nvme22n1
    check_device nvme23n1
    check_device nvme24n1
}

function print_devices
{
    for device in "${devices[@]}"
    do
        echo Found device $device
    done
}


function do_mount
{
    echo Mounting device $1 on $2 on $3
fdisk $1 << EOF
n
p
1



w
EOF

# format!

mkfs -t xfs -f $1

mkdir $2

mount $1 $2
export si=$4$iv
sudo /opt/beegfs/sbin/beegfs-setup-meta -p /desk0/beegfs/beegfs_meta -s $4 -m $3
sudo /opt/beegfs/sbin/beegfs-setup-storage -p /$2/beegfs_storage -s $4 -i $si -m $3
echo $si >> si

echo "$1   $2      xfs     defaults          0 0" >> /etc/fstab
echo $iv 


}

function mount_devices
{
    for (( i = 1 ; i < ${#devices[@]} ; i++ ))
    do
        ivv=$(printf "%02d\n" $i)
        iv=${ivv}
        mountTarget=/desk$iv

        do_mount /dev/${devices[10#$iv-1]} $mountTarget $1 $2
        echo /desk$iv >> deskname
        echo /dev/${devices[10#$iv-1]} >> deskname
        #echo $1 >> function1
        #echo $2 >> nodeid
    done
}


check_devices
print_devices
mount_devices $privateip $nodeid


