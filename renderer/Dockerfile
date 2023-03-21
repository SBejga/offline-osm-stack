FROM dpokidov/gopnik

RUN apt-get update && \
    apt-get install -y git curl unzip node-carto mapnik-utils fontconfig && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

# RUN wget https://github.com/adobe-fonts/source-sans/releases/download/3.046R/TTF-source-sans-3.046R.zip && \
#     unzip -qqun TTF-source-sans-3.046R.zip && \
#     mkdir /usr/share/fonts/truetype/sourcesans-ttf/ && \
#     cp TTF-source-sans-3.046R/*.ttf /usr/share/fonts/truetype/sourcesans-ttf/ && \
#     fc-cache && \
#     rm TTF-source-sans-3.046R.zip && \
#     rm -rf TTF-source-sans-3.046R

RUN git clone https://github.com/dooman87/openstreetmap-carto.git
WORKDIR /openstreetmap-carto
ADD shapes/ data/
RUN shapeindex --shape_files \
    data/world_boundaries/world_boundaries.shp \
    data/water-polygons-split-3857/water_polygons.shp \
    data/antarctica-icesheet-polygons-3857/icesheet_polygons.shp \
    data/antarctica-icesheet-outlines-3857/icesheet_outlines.shp \
    data/ne_10m_admin_0_boundary_lines_land/ne_10m_admin_0_boundary_lines_land.shp

RUN mkdir /map_data
VOLUME /map_data

RUN mkdir /scripts
COPY scripts/compile_style.sh /scripts
COPY scripts/run_render.sh /scripts
COPY entrypoint.sh /

RUN chmod 755 /scripts/*.sh && \
    chmod 755 /entrypoint.sh

WORKDIR /
ENTRYPOINT /entrypoint.sh