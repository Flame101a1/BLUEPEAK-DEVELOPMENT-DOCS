-- Run after backing up an existing inventories table. Safe to repeat.
SET @has_type = (SELECT COUNT(*) FROM information_schema.COLUMNS
 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'inventories' AND COLUMN_NAME = 'type');
SET @upgrade = IF(@has_type = 0,
 'ALTER TABLE inventories ADD COLUMN type VARCHAR(50) DEFAULT NULL AFTER identifier', 'SELECT 1');
PREPARE inventory_upgrade FROM @upgrade;
EXECUTE inventory_upgrade;
DEALLOCATE PREPARE inventory_upgrade;
