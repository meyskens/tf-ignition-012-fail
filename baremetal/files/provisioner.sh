#!/bin/bash

function __build_grub {
    local driver=${1}
    local file="/mnt/boot/grub/grub.cfg"
    /bin/cat <<EOM >${file}
#
# DO EDIT THIS FILE
#
# It is handcrafted by Maartje
# knowledge of dark magic required
#

terminal_input console
terminal_output console

set default=0
set timeout=10

menuentry "Network boot (iPXE)" --id pxe {
    linux16 /boot/${driver}
}
EOM
}

function __bootstrap {
    local disk=${1}
    local driver=${2}
    (
    echo o      # Create a new empty partition table
    echo y      # Accept overwriting
    echo n      # Add a new partition
    echo 1      # Partition number
    echo 2048   # First sector
    echo +1M    # Last sector
    echo ef02   # Hex code for BIOS boot partition
    echo n      # Add new partition
    echo 2      # Partition number
    echo        # Accept default first sector
    echo +300MB # Last sector
    echo        # Accept default GUID
    echo n      # Add new partition
    echo 3      # Partition number
    echo        # Accept default first sector
    echo        # Last default last sector
    echo        # Accept default GUID
    echo w      # Write changes
    echo y      # Accpept write
    ) | gdisk "${disk}"

    mkfs.ext4 -F "${disk}2"
    mount "${disk}2" /mnt

    grub-install --root-directory=/mnt "${disk}"
    cp "/tmp/${driver}" "/mnt/boot/${driver}"
    __build_grub "${driver}"
    umount /mnt
}

function bootstrap {
    local driver=${1}
    local disk
    for disk in /dev/sd{a,b,c}; do
        echo "Bootstrapping $disk"
        [ -e "$disk" ] && __bootstrap "$disk" "$driver"
    done
}

function make-raid {
    local alphabet=({a..z})
    local level=1

    if [ "${1}" -gt "2" ]; then
        level=5
    fi

    if [ "${2}" != "" ]; then
        level="${2}"
    fi

    local disks=""
    local counter=0

    while [ $counter -lt "${1}" ]; do
        disks+="/dev/sd${alphabet[$counter]}3 "
        ((counter++))
    done
    # Do not quote ${disks} as we really want the spaces there
    mdadm --create --run --verbose /dev/md0 --level="${level}" --raid-devices="${1}" ${disks}
}

function unbusy-disks {
    local dev
    mdadm --detail --scan | cut -d " " -f 2 | while read -r dev; do
        mdadm --stop "${dev}"
    done

    local filename type size used priority
    swapon --summary | tail -n +2 | while read -r filename type size used priority; do
        swapoff "${filename}"
    done
}

function rm-hwraid {
    megacli -CfgLdDel -L0 -a0 # Remove virtual drive 0 from raid controller 0
    local drives
    drives=$(megaclisas-status | grep '\[.*\]' -o)

    local line
    while read -r line; do
        echo "configuring $line"
        megacli -CfgLdAdd -r0"$line" -a0 # Configures a RAID 0 per drive, which is the same as non RAID
    done <<< "${drives}"
}

function format {
    local disk=${1}
    local label=${2}

    apt-get update
    apt-get install -y xfsprogs

    mkfs.xfs -f -L "${label}" "${disk}"
}


FUNC=${1}

case ${FUNC} in 
    bootstrap)
        [ $# -ne 2 ] && { echo "Usage: $0 bootstrap driver"; exit 1; }
        bootstrap "${2}"
        ;;
    make-raid)
        [ $# -lt 2 ] && { echo "Usage: $0 make-raid ndisks [level]"; exit 1; }
        make-raid "${2}" "${3}"
        ;;
    unbusy-disks)
        unbusy-disks
        ;;
    rm-hwraid)
        rm-hwraid
        ;;
    format)
       [ $# -ne 3 ] && { echo "Usage: $0 format disk label"; exit 1; } 
        format "$2" "$3"
        ;;
    *)
        echo $"Usage: $0 {bootstrap|make-raid|unbusy-disks|rm-hwraid|format} [args]"
        exit 1
        ;;
esac
