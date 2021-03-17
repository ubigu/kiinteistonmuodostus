#/bin/sh

IMAGE=./output/diagrams/summary/relationships.implied.large.png
OUTDIR=./images
if [ -f "$IMAGE" ];
then
    cp "$IMAGE" $OUTDIR
    echo "Updated image to $OUTDIR"
else
    echo "Error: source image ($IMAGE) not found."
    exit 1
fi
