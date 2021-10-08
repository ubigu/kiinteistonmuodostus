#!/bin/sh
sed '/type: EXTENSION/,/-- ddl-end/ d'
