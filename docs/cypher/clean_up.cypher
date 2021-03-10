MATCH (n) detach delete n;
DROP INDEX Inventory_Id;
DROP INDEX Part_Number;
DROP INDEX Element_Id;
DROP INDEX Color_ColorId;
DROP INDEX Set_Number;
DROP INDEX PartGroup_InventoryIdAndPartNumber;
DROP INDEX PartGroup_InventoryIdAndPartNumberColorIdIsSpare;