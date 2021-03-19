#!/usr/bin/env bash
cat import.cypher | /var/lib/neo4j/bin/cypher-shell -u neo4j -p secret