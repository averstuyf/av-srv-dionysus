rsync -r -e ssh --progress --remove-source-files --exclude-from='exclude-on-move.txt' ~/Downloads/plex/ arnaud@192.168.86.11:/srv/media/        
find ~/Downloads/plex/ -depth -type d -empty -delete