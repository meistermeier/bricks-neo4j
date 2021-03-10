CREATE INDEX Inventory_Id FOR (i:Inventory) on (i.inventoryId);
CREATE INDEX Part_Number FOR (p:Part) on (p.partNumber);
CREATE INDEX Color_ColorId FOR (c:Color) on (c.colorId);
CREATE INDEX Set_Number FOR (s:Set) on (s.number);
CREATE INDEX Element_Id FOR (e:Element) on (e.elementId);

// composite index only available in Neo4j Enterprise
// btw. did you try Neo4j Desktop with built-in Neo4j Enterprise edition? https://neo4j.com/download/
CREATE INDEX PartGroup_InventoryIdAndPartNumber FOR (pg:PartGroup) on (pg.inventoryId, pg.partNumber);
CREATE INDEX PartGroup_InventoryIdAndPartNumberColorIdIsSpare FOR (pg:PartGroup) on (pg.inventoryId, pg.partNumber, pg.colorId, pg.isSpare);