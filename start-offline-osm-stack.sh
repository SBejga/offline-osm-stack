cd /e/offline-osm-stack
docker compose up -d
echo "docker compose up"
echo "show logs"
docker compose logs -f