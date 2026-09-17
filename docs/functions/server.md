# Server functions

Call these exports from **server scripts**. Resource name: `qb-inventory`. Quantities use `amount`, item metadata uses `info`, and weights are in grams.

!!! warning "Trust boundary"
    These exports are for trusted server integrations. Validate caller permissions, item names, quantities and target inventories before invoking them. Do not expose arbitrary inventory IDs through an unvalidated network event.

## Identifiers

Use a numeric player server ID for player operations and a string for named storage, such as `stash-example`, `glovebox-PLATE` or `trunk-PLATE`. Named storage must exist in memory for most mutations. `GetInventory` is a cache lookup. Backpack IDs belong to individual items; do not generate replacement IDs when transferring bags.

## LoadInventory

Loads a player inventory from the database using the citizen ID and resolves its item definitions.

```lua
exports['qb-inventory']:LoadInventory(source, citizenid)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `citizenid` \| `string` | Persistent QBCore citizen ID. |

**Returns:** Item table.

## SaveInventory

Saves a player inventory. With offline enabled, source is an offline PlayerData table rather than a server ID.

```lua
exports['qb-inventory']:SaveInventory(source, offline)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `offline` \| `boolean?` | Whether source is an offline PlayerData table. |

**Returns:** No documented return value.

## SetInventory

Replaces the inventory item table. This is a low-level mutation; authorize the operation and supply valid item instances.

```lua
exports['qb-inventory']:SetInventory(identifier, items, reason)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `items` \| `table|string` | Item table or requested item name/list; see function description. |
| `reason` \| `string?` | Reason for logs or integrations. |

**Returns:** No documented return value.

## SetItemData

Sets a top-level field on a player item. To change metadata, pass key `info` and the complete updated metadata table.

```lua
exports['qb-inventory']:SetItemData(source, itemName, key, val, slot)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `itemName` \| `string` | Shared item name. |
| `key` \| `string` | Top-level field to change. |
| `val` \| `any` | Replacement field value. |
| `slot` \| `number?` | Inventory slot; omit/false where supported for automatic selection. |

**Returns:** True on success; false or nil on failure.

### Example

```lua
local item = exports['qb-inventory']:GetItemBySlot(source, 1)
if item then
    local info = item.info or {}
    info.quality = 100
    exports['qb-inventory']:SetItemData(source, item.name, 'info', info, item.slot)
end
```

## UseItem

Invokes a registered QBCore usable-item callback, forwarding the supplied arguments.

```lua
exports['qb-inventory']:UseItem(itemName, ...)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `itemName` \| `string` | Shared item name. |
| `...` \| `any` | Arguments forwarded to the usable-item callback. |

**Returns:** No documented return value.

## GetSlotsByItem

Finds matching slot keys in an item table.

```lua
exports['qb-inventory']:GetSlotsByItem(items, itemName)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `items` \| `table|string` | Item table or requested item name/list; see function description. |
| `itemName` \| `string` | Shared item name. |

**Returns:** Table of matching slot keys.

## GetFirstSlotByItem

Finds the first matching slot number in an item table.

```lua
exports['qb-inventory']:GetFirstSlotByItem(items, itemName)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `items` \| `table|string` | Item table or requested item name/list; see function description. |
| `itemName` \| `string` | Shared item name. |

**Returns:** Slot number, or nil.

## GetItemBySlot

Looks up an item in the player inventory, with the implemented equipped-backpack lookup fallback.

```lua
exports['qb-inventory']:GetItemBySlot(source, slot)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `slot` \| `number?` | Inventory slot; omit/false where supported for automatic selection. |

**Returns:** Item table, or nil.

### Example

```lua
local item = exports['qb-inventory']:GetItemBySlot(source, 1)
if item then print(item.name, item.amount) end
```

## GetTotalWeight

Sums item weight multiplied by amount for an item table.

```lua
exports['qb-inventory']:GetTotalWeight(items)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `items` \| `table|string` | Item table or requested item name/list; see function description. |

**Returns:** Weight in grams.

## GetItemByName

Finds a named item in player storage, including the implemented equipped-backpack lookup.

```lua
exports['qb-inventory']:GetItemByName(source, item)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `item` \| `string` | Shared item name, such as water_bottle. |

**Returns:** Item table, or nil.

## GetItemsByName

Collects matching named items from the player and equipped-backpack storage.

```lua
exports['qb-inventory']:GetItemsByName(source, item)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `item` \| `string` | Shared item name, such as water_bottle. |

**Returns:** Table of matching items.

## GetSlots

Returns occupied and free slot counts for a loaded inventory.

```lua
exports['qb-inventory']:GetSlots(identifier)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |

**Returns:** `slotsUsed, slotsFree`; for unknown storage, `0, nil` may be returned.

## GetItemCount

Counts named items in the player item table. For a list of names, returns the combined count.

```lua
exports['qb-inventory']:GetItemCount(source, items)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `items` \| `table|string` | Item table or requested item name/list; see function description. |

**Returns:** Number, or nil for a missing player.

## CanAddItem

Checks item weight and available slots. This is a capacity check, not a job/access or complete container-filter check. Check the AddItem result too.

```lua
exports['qb-inventory']:CanAddItem(identifier, item, amount)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `item` \| `string` | Shared item name, such as water_bottle. |
| `amount` \| `number` | Positive item quantity; SetItem uses an absolute quantity. |

**Returns:** `boolean, reason?`; reason can be `weight` or `slots`. Other failures may have no reason.

### Example

```lua
local canAdd, reason = exports['qb-inventory']:CanAddItem(source, 'water_bottle', 2)
if not canAdd then print(reason or 'Cannot add this item') end
```

## GetFreeWeight

Returns remaining player carry capacity in grams.

```lua
exports['qb-inventory']:GetFreeWeight(source)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |

**Returns:** Remaining grams; invalid player/source returns 0.

## ClearInventory

Clears player inventory, keeping items named by filterItems when provided. Protected-slot rules do not make this administrative export a safe search operation.

```lua
exports['qb-inventory']:ClearInventory(source, filterItems)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `filterItems` \| `string|table?` | Item names to retain when clearing. |

**Returns:** No documented return value.

## HasItem

Checks the requested items and quantities against player and equipped-backpack storage.

```lua
exports['qb-inventory']:HasItem(source, items, amount)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `items` \| `table|string` | Item table or requested item name/list; see function description. |
| `amount` \| `number` | Positive item quantity; SetItem uses an absolute quantity. |

**Returns:** Boolean.

### Example

```lua
local hasWater = exports['qb-inventory']:HasItem(source, 'water_bottle', 1)
```

## CloseInventory

Releases an inventory open flag when an identifier is supplied, clears the player busy state and requests client closure.

```lua
exports['qb-inventory']:CloseInventory(source, identifier)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |

**Returns:** No documented return value.

## OpenInventoryById

Opens another player inventory for the viewer. The protected-slot police exception is applied. Your calling resource must authorize the search and enforce proximity.

```lua
exports['qb-inventory']:OpenInventoryById(source, targetId)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `targetId` \| `number` | Target player server ID. |

**Returns:** No documented return value.

## ClearStash

Clears a loaded stash and updates its stored items. This deletes its contents.

```lua
exports['qb-inventory']:ClearStash(identifier)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |

**Returns:** No documented return value.

## CreateShop

Registers one shop definition or a collection of shop definitions.

```lua
exports['qb-inventory']:CreateShop(shopData)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `shopData` \| `table` | Shop definition(s), including name, items and optional coordinates. |

**Returns:** No documented return value.

### Example

```lua
exports['qb-inventory']:CreateShop({
    name = 'example-shop', label = 'Supplies',
    items = { { name = 'water_bottle', price = 5, amount = 20 } }
})
exports['qb-inventory']:OpenShop(source, 'example-shop')
```

## OpenShop

Opens a registered shop for a player; use the exact registered name.

```lua
exports['qb-inventory']:OpenShop(source, name)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `name` \| `string` | Registered shop name. |

**Returns:** No documented return value.

## OpenInventory

Opens personal inventory or a named storage inventory. Weapon racks are attached through gloveboxes rather than opened directly. Authorize custom stash access in your calling resource.

```lua
exports['qb-inventory']:OpenInventory(source, identifier, data)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `source` \| `number` | Player server ID (see offline SaveInventory exception). |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `data` \| `table?` | Storage options: label, slots and maxweight. |

**Returns:** No documented return value.

### Example

```lua
-- Call only after your server-side access checks succeed.
exports['qb-inventory']:OpenInventory(source, 'locker-example', {
    label = 'Locker', slots = 20, maxweight = 50000
})
```

## CreateInventory

Initializes a named inventory in memory if it does not exist. It does not itself insert a database row.

```lua
exports['qb-inventory']:CreateInventory(identifier, data)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `data` \| `table?` | Storage options: label, slots and maxweight. |

**Returns:** No documented return value.

## GetInventory

Returns the loaded storage object from the server inventory cache. It does not query the database.

```lua
exports['qb-inventory']:GetInventory(identifier)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |

**Returns:** Inventory table or nil.

## RemoveInventory

Removes a named inventory from memory. This does not delete its database record.

```lua
exports['qb-inventory']:RemoveInventory(identifier)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |

**Returns:** No documented return value.

## AddItem

Adds an item to player or loaded storage. Backpack nesting and weapon-rack item restrictions apply. Cash items use the cash synchronization path when enabled. Validate inputs and permissions before calling.

```lua
exports['qb-inventory']:AddItem(identifier, item, amount, slot, info, reason)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `item` \| `string` | Shared item name, such as water_bottle. |
| `amount` \| `number` | Positive item quantity; SetItem uses an absolute quantity. |
| `slot` \| `number?` | Inventory slot; omit/false where supported for automatic selection. |
| `info` \| `table?` | Item instance metadata. |
| `reason` \| `string?` | Reason for logs or integrations. |

**Returns:** Boolean indicating success.

### Example

```lua
local ok = exports['qb-inventory']:AddItem(source, 'water_bottle', 1, false, {}, 'example-reward')
if not ok then
    return -- No reward was added; handle this outcome.
end
```

## RemoveItem

Removes an item amount from a player or loaded storage. Supply a slot to target a particular instance.

```lua
exports['qb-inventory']:RemoveItem(identifier, item, amount, slot, reason)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `item` \| `string` | Shared item name, such as water_bottle. |
| `amount` \| `number` | Positive item quantity; SetItem uses an absolute quantity. |
| `slot` \| `number?` | Inventory slot; omit/false where supported for automatic selection. |
| `reason` \| `string?` | Reason for logs or integrations. |

**Returns:** Boolean indicating success.

### Example

```lua
local removed = exports['qb-inventory']:RemoveItem(source, 'water_bottle', 1, nil, 'example-use')
if removed then
    -- Apply the effect only after a successful removal.
end
```

## ContainerHasItem

Checks whether a named container contains an item, using cached contents or loading stored items from the database.

```lua
exports['qb-inventory']:ContainerHasItem(containerId, itemName)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `containerId` \| `string` | Persistent container identifier. |
| `itemName` \| `string` | Shared item name. |

**Returns:** Boolean.

## SetItem

Sets an absolute item quantity. This is a low-level export; it is not a substitute for the UI transfer authorization or container rules.

```lua
exports['qb-inventory']:SetItem(identifier, item, amount, reason)
```

| Parameter | Type | Meaning |
| --- | --- | --- |
| `identifier` \| `number|string` | Player server ID or loaded storage identifier, depending on the function. |
| `item` \| `string` | Shared item name, such as water_bottle. |
| `amount` \| `number` | Positive item quantity; SetItem uses an absolute quantity. |
| `reason` \| `string?` | Reason for logs or integrations. |

**Returns:** Boolean indicating success.

## CreateCustomDrop

Creates a physical drop or merges into a nearby drop within the configured merge radius.

```lua
local dropId = exports['qb-inventory']:CreateCustomDrop({
    coords = vector3(100.0, 200.0, 30.0),
    label = 'Supplies',
    slots = 5,
    maxweight = 10000,
    items = { { name = 'water_bottle', amount = 2, info = {} } },
})
```

| Option | Type | Meaning |
| --- | --- | --- |
| `coords` \| `vector3` or coordinate table | Required world position |
| `items` \| `table` | Item definitions with name, amount and optional info/slot |
| `label` \| `string?` | Display label; defaults to Drop |
| `slots` \| `number?` | Slot capacity; defaults to configured drop capacity |
| `maxweight` \| `number?` | Weight capacity in grams |
| `model` \| `string?` | Optional drop prop model |
| `oneItemOneProp` \| `boolean?` | Override the configured prop mode |

**Returns:** drop ID. Invalid options or coordinates can raise an error. A nearby drop may be reused rather than creating a new one.

## RemoveDrop

Removes a drop and its associated props.

```lua
exports['qb-inventory']:RemoveDrop(dropId)
```

`dropId` is the existing drop identifier. No return value is documented.

## Internal helpers

Weapon-rack access, protected-slot authorization and backpack opening helpers are internal Lua functions, not public exports. Configure those systems through the documented settings instead of calling internal network events.
