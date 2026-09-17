-- Merge these entries into the table in qb-core/shared/items.lua.
-- Update existing entries instead of defining duplicate keys. This file is not auto-loaded.
return {
    backpack_small = { name = 'backpack_small', label = 'Small Backpack', weight = 350, type = 'item', image = 'backpack_small.png', unique = true, useable = true, shouldClose = true, description = 'A compact personal backpack.' },
    backpack_medium = { name = 'backpack_medium', label = 'Medium Backpack', weight = 500, type = 'item', image = 'backpack_medium.png', unique = true, useable = true, shouldClose = true, description = 'A medium personal backpack.' },
    backpack_large = { name = 'backpack_large', label = 'Large Backpack', weight = 700, type = 'item', image = 'backpack_large.png', unique = true, useable = true, shouldClose = true, description = 'A large personal backpack.' },
    armor = { name = 'armor', label = 'Armor', weight = 5000, type = 'item', image = 'armor.png', unique = true, useable = true, shouldClose = true, description = 'A protective vest.' },
    heavyarmor = { name = 'heavyarmor', label = 'Heavy Armor', weight = 5000, type = 'item', image = 'heavy_armor.png', unique = true, useable = true, shouldClose = true, description = 'A reinforced protective vest.' },
    armor_repair_kit = { name = 'armor_repair_kit', label = 'Armor Repair Kit', weight = 600, type = 'item', image = 'armor.png', unique = false, useable = true, shouldClose = true, description = 'Restores equipped armor durability.' },
    armor_plates = { name = 'armor_plates', label = 'Armor Plates', weight = 250, type = 'item', image = 'armor.png', unique = false, useable = true, shouldClose = true, description = 'Replacement vest plates.' },
    money = { name = 'money', label = 'Cash', weight = 0, type = 'item', image = 'money.png', unique = false, useable = false, shouldClose = false, description = 'Cash money.' },
}
