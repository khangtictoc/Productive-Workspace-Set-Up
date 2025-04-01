# Fix cache error
## Case1: Empty the cache
sudo rm -r /var/lib/apt/lists/*
sudo apt-get clean && sudo apt-get update
## Case 2: Update newest status file from available backup
mv /var/lib/dpkg/status /var/lib/dpkg/status.old
ls -l /var/backups/dpkg.status*
cp /var/backups/dpkg.status.0 /var/lib/dpkg/status