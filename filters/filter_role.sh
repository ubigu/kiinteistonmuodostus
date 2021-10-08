#!/bin/sh
sed '/type: ROLE/,/-- ddl-end/ d'
