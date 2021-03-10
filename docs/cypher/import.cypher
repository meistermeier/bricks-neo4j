USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///sets.csv' AS set
CREATE (:Set{number: set.set_num, name: set.name, year: toInteger(set.year), numberOfParts: toInteger(set.num_parts)});

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///inventories.csv' AS inventory
CREATE (i:Inventory{inventoryId: toInteger(inventory.id)});

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///parts.csv' AS part
CREATE (p:Part{partNumber: part.part_num, name: part.name});

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///colors.csv' AS color
CREATE (:Color{colorId: toInteger(color.id), name: color.name, rgb: color.rgb, transparent: CASE color.is_trans when 'f' then false else true end});

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///inventory_parts.csv' AS inventory_parts
CREATE (pg:PartGroup{inventoryId: toInteger(inventory_parts.inventory_id), partNumber: inventory_parts.part_num, isSpare: CASE inventory_parts.is_spare when 'f' then false else true end, colorId: toInteger(inventory_parts.color_id)});

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///elements.csv' AS elements
CREATE (e:Element{elementId: elements.element_id, partNumber: elements.part_num});

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///inventories.csv' AS inventory
MATCH (s:Set{number: inventory.set_num})
MATCH (i:Inventory{inventoryId: toInteger(inventory.id)})
MERGE (s)-[:DEFINED_BY]->(i);

// To get a unique node for the relationship creation later, we need to set colorId as a property.
USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///inventory_parts.csv' AS inventory_parts
MATCH (pg:PartGroup{inventoryId: toInteger(inventory_parts.inventory_id), partNumber: inventory_parts.part_num, colorId: toInteger(inventory_parts.color_id), isSpare: CASE inventory_parts.is_spare when 'f' then false else true end})
MATCH (i:Inventory{inventoryId: toInteger(inventory_parts.inventory_id)})
CREATE (i)-[:NEEDS]->(pg);

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///inventory_parts.csv' AS inventory_parts
MATCH (pg:PartGroup{inventoryId: toInteger(inventory_parts.inventory_id), partNumber: inventory_parts.part_num, colorId: toInteger(inventory_parts.color_id), isSpare: CASE inventory_parts.is_spare when 'f' then false else true end})
MATCH (c:Color{colorId: toInteger(inventory_parts.color_id)})
CREATE (pg)-[:HAS_COLOR]->(c);

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///inventory_parts.csv' AS inventory_parts
MATCH (pg:PartGroup{inventoryId: toInteger(inventory_parts.inventory_id), partNumber: inventory_parts.part_num, colorId: toInteger(inventory_parts.color_id), isSpare: CASE inventory_parts.is_spare when 'f' then false else true end})
MATCH (p:Part{partNumber: inventory_parts.part_num})
CREATE (pg)<-[:IS_PART_OF{quantity: toInteger(inventory_parts.quantity)}]-(p);

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///elements.csv' AS elements
MATCH (e:Element{elementId: elements.element_id})
MATCH (p:Part{partNumber: elements.part_num})
CREATE (p)-[:IS]->(e);

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///elements.csv' AS elements
MATCH (e:Element{elementId: elements.element_id})
MATCH (c:Color{colorId: toInteger(elements.color_id)})
CREATE (e)-[:HAS_COLOR]->(c);

USING PERIODIC COMMIT LOAD CSV WITH HEADERS FROM 'file:///parts.csv' AS part
MATCH (p:Part{partNumber: part.part_num, name: part.name})
MERGE (m:Material{material: part.part_material})
MERGE (p)-[:MADE_OF]->(m);