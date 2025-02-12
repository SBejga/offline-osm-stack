
# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'template_postgis' template db
psql --dbname="$POSTGRES_DB" <<- 'EOSQL'
CREATE DATABASE template_postgis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	psql --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION postgis;
		CREATE EXTENSION postgis_topology;
		CREATE EXTENSION fuzzystrmatch;
		CREATE EXTENSION postgis_tiger_geocoder;
		CREATE EXTENSION hstore;
EOSQL
done

# import _.osm.pbf
echo "starting osm2pgsql..."
osm2pgsql --style /openstreetmap-carto/openstreetmap-carto.style -d gis -U postgres -k --slim /region.osm.pbf
echo "finished osm2pgsql!"

touch /var/lib/postgresql/data/DB_INITED
echo "done: DB_INITED"