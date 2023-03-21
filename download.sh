#!/usr/bin/env bash

set -e -u

## OSM PBF
OSM_DIR=data-osm-pbf
OSM_FILE=oberbayern-latest.osm.pbf
echo "downloading $OSM_FILE..."
curl http://download.geofabrik.de/europe/germany/bayern/$OSM_FILE --output $OSM_DIR/$OSM_FILE
echo "download complete $OSM_FILE"

## SHAPES for Renderer
UNZIP_OPTS=-qqun
SHAPES_DIR=renderer/shapes
mkdir -p ${SHAPES_DIR}

# world_boundaries
mkdir -p ${SHAPES_DIR}/world_boundaries
echo "downloading world_boundaries..."
curl -z "${SHAPES_DIR}/world_boundaries-spherical.tgz" -L -o "${SHAPES_DIR}/world_boundaries-spherical.tgz" "http://planet.openstreetmap.org/historical-shapefiles/world_boundaries-spherical.tgz"
echo "expanding world_boundaries..."
tar -xzf ${SHAPES_DIR}/world_boundaries-spherical.tgz -C ${SHAPES_DIR}/

# ne_10m_admin_0_boundary_lines_land
mkdir -p ${SHAPES_DIR}/ne_10m_admin_0_boundary_lines_land
echo "downloading ne_10m_admin_0_boundary_lines_land..."
curl -z ${SHAPES_DIR}/ne_10m_admin_0_boundary_lines_land.zip -L -o ${SHAPES_DIR}/ne_10m_admin_0_boundary_lines_land.zip https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_boundary_lines_land.zip
echo "expanding ne_10m_admin_0_boundary_lines_land..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/ne_10m_admin_0_boundary_lines_land.zip \
  ne_10m_admin_0_boundary_lines_land.shp \
  ne_10m_admin_0_boundary_lines_land.shx \
  ne_10m_admin_0_boundary_lines_land.prj \
  ne_10m_admin_0_boundary_lines_land.dbf \
  -d ${SHAPES_DIR}/ne_10m_admin_0_boundary_lines_land/

# ne_110m_admin_0_boundary_lines_land
mkdir -p ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land
echo "downloading ne_110m_admin_0_boundary_lines_land..."
curl -z ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land.zip -L -o ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land.zip https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_boundary_lines_land.zip
echo "expanding ne_110m_admin_0_boundary_lines_land..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land.zip \
  ne_110m_admin_0_boundary_lines_land.shp \
  ne_110m_admin_0_boundary_lines_land.shx \
  ne_110m_admin_0_boundary_lines_land.prj \
  ne_110m_admin_0_boundary_lines_land.dbf \
  -d ${SHAPES_DIR}/ne_110m_admin_0_boundary_lines_land/

# water-polygons-split-3857
mkdir -p ${SHAPES_DIR}/water-polygons-split-3857
echo "downloading water-polygons-split-3857..."
curl -z "${SHAPES_DIR}/water-polygons-split-3857.zip" -L -o "${SHAPES_DIR}/water-polygons-split-3857.zip" "https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip"
echo "water-polygons-split-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/water-polygons-split-3857.zip \
  water-polygons-split-3857/water_polygons.shp \
  water-polygons-split-3857/water_polygons.shx \
  water-polygons-split-3857/water_polygons.prj \
  water-polygons-split-3857/water_polygons.dbf \
  water-polygons-split-3857/water_polygons.cpg \
  -d ${SHAPES_DIR}/

# antarctica-icesheet-polygons-3857
echo "downloading antarctica-icesheet-polygons-3857..."
curl -z "${SHAPES_DIR}/antarctica-icesheet-polygons-3857.zip" -L -o "${SHAPES_DIR}/antarctica-icesheet-polygons-3857.zip" "https://osmdata.openstreetmap.de/download/antarctica-icesheet-polygons-3857.zip"
echo "expanding antarctica-icesheet-polygons-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/antarctica-icesheet-polygons-3857.zip \
  antarctica-icesheet-polygons-3857/icesheet_polygons.shp \
  antarctica-icesheet-polygons-3857/icesheet_polygons.shx \
  antarctica-icesheet-polygons-3857/icesheet_polygons.prj \
  antarctica-icesheet-polygons-3857/icesheet_polygons.dbf \
  -d ${SHAPES_DIR}/

# antarctica-icesheet-outlines-3857
echo "downloading antarctica-icesheet-outlines-3857..."
curl -z "${SHAPES_DIR}/antarctica-icesheet-outlines-3857.zip" -L -o "${SHAPES_DIR}/antarctica-icesheet-outlines-3857.zip" "https://osmdata.openstreetmap.de/download/antarctica-icesheet-outlines-3857.zip"
echo "expanding antarctica-icesheet-outlines-3857..."
unzip $UNZIP_OPTS ${SHAPES_DIR}/antarctica-icesheet-outlines-3857.zip \
  antarctica-icesheet-outlines-3857/icesheet_outlines.shp \
  antarctica-icesheet-outlines-3857/icesheet_outlines.shx \
  antarctica-icesheet-outlines-3857/icesheet_outlines.prj \
  antarctica-icesheet-outlines-3857/icesheet_outlines.dbf \
  -d ${SHAPES_DIR}/

rm renderer/shapes/*.zip
rm renderer/shapes/*.tgz


