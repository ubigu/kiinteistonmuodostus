#/bin/sh

IMAGE=./output/diagrams/summary/relationships.implied.large.png
OUTDIR=./images

# Try to guess autogenerated image contents.
# If docker-compose has certain sql in comments,
# image contains only tonttijako data model
OUTFILE=tonttijako.png
if $(grep -v '^\s*#' docker-compose.yml | grep -q 12_kiinteisto\.sql);
then
    OUTFILE=tonttijako_kiinteisto.png
fi

if [ -f "$IMAGE" ];
then
    cp "$IMAGE" $OUTDIR/$OUTFILE
    echo "Updated image to $OUTDIR/$OUTFILE"
else
    echo "Error: source image ($IMAGE) not found."
    exit 1
fi
