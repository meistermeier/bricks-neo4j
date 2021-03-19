ARG NEO4J_VERSION=4.2
FROM neo4j:${NEO4J_VERSION}

ADD https://cdn.rebrickable.com/media/downloads/colors.csv.gz /var/lib/neo4j/import/colors.csv.gz
ADD https://cdn.rebrickable.com/media/downloads/sets.csv.gz /var/lib/neo4j/import/sets.csv.gz
ADD https://cdn.rebrickable.com/media/downloads/inventories.csv.gz /var/lib/neo4j/import/inventories.csv.gz
ADD https://cdn.rebrickable.com/media/downloads/parts.csv.gz /var/lib/neo4j/import/parts.csv.gz
ADD https://cdn.rebrickable.com/media/downloads/inventory_parts.csv.gz /var/lib/neo4j/import/inventory_parts.csv.gz
ADD https://cdn.rebrickable.com/media/downloads/elements.csv.gz /var/lib/neo4j/import/elements.csv.gz

WORKDIR /var/lib/neo4j/import/
# It seems that I am too stupid for a gunzip *.gz
RUN ["gunzip", "colors.csv.gz"]
RUN ["gunzip", "sets.csv.gz"]
RUN ["gunzip", "inventories.csv.gz"]
RUN ["gunzip", "parts.csv.gz"]
RUN ["gunzip", "inventory_parts.csv.gz"]
RUN ["gunzip", "elements.csv.gz"]

COPY import.cypher /var/lib/neo4j/import/
COPY import.sh /var/lib/neo4j/import/

ENV NEO4J_AUTH=neo4j/secret

EXPOSE 7474
EXPOSE 7687