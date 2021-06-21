scp -rp src/docker-compose.yml arnaud@192.168.86.11:./

# Deploy all subfolders one level deep
#for d in ./*/ ; do (cd "$d" && ./deploy-to-prod.sh); done