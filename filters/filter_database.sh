#!/bin/sh
sed '/type: DATABASE/,/-- ddl-end/ d'
