# mount-apfs
This is a really stupid and basic Bash script to mount and unmount APFS drives in a Linux environment.

This is **NOT** a driver for APFS drives. It uses [apfs-fuse](https://github.com/sgan81/apfs-fuse), which is required for this script to work.

# Usage
 - Option ``-m`` allows to mount a drive. If not specified by the user, the default location for the selected drive is ``/dev/nvme0n1p2``. To specify a different drive, just type it after the option.
 - Option ``-u`` allows to unmount a previously mounted drive. It does so by unmounting the ``/media/$USERNAME/macos/`` folder.
 - Any other option will show a help paragraph, similar to this README.

#### Further development
It's incredible to think this stupid thing might require further development, am I right?
Anyhoo, I plan to allow the user to mount and unmount multiple drives at once, and differentiate between them. As of right now, it is impossible to mount multiple drives.
