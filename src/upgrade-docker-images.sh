sudo docker-compose down  --remove-orphans
sudo docker rmi homebridge/homebridge
# sudo docker rmi nitrikx/plex-cleaner
sudo docker rmi plexinc/pms-docker
sudo docker-compose up -d
# Delete all unused images
sudo docker image prune -a -f
