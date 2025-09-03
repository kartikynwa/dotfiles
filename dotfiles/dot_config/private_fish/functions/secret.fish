function secret -a command
    if test -z $ZFS_SECRET_FS
        return 1
    end

    if test -z $ZFS_SECRET_MOUNTPOINT
        return 2
    end

    if test $command = load
        mkdir -p $ZFS_SECRET_MOUNTPOINT
        sudo zfs set mountpoint=$ZFS_SECRET_MOUNTPOINT $ZFS_SECRET_FS
        sudo zfs load-key $ZFS_SECRET_FS
        sudo zfs mount $ZFS_SECRET_FS
    else if test $command = unload
        sudo zfs umount $ZFS_SECRET_FS
        sudo zfs unload-key $ZFS_SECRET_FS
        sudo zfs set mountpoint=none $ZFS_SECRET_FS
        rmdir $ZFS_SECRET_MOUNTPOINT
    else
        return 4
    end
end
