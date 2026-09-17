# Item definitions

## Item setup

The sample entries include all three backpacks, armor, heavy armor, repair kits, plates, and cash. Included image filenames are used; repair items reuse `armor.png` until you supply dedicated artwork.

Backpacks must be `unique = true` so each bag retains its own storage identity. Their shared item `weight` is the empty bag's weight; storage capacity is a separate value under `Config.UtilitySlots.backpackItems`.

If `CashAsItem` is enabled (the default), register the `money` item as zero-weight and stackable. See [CASH_AS_ITEM_README.md](items.md). Avoid adding a second cash synchronization resource.

Custom container entries under `ItemContainers` also need matching QBCore item definitions. The supplied `weapon_briefcase` configuration is an example; define that item if you intend to use it. Existing food, medicine, armor, and other usable items still rely on your server's item-use integrations where applicable.

## Cash item

Cash-as-item defaults to enabled. The `money` item must be zero-weight and stackable. Its quantity is synchronized with the player's QBCore cash balance. Do not install a second cash synchronization resource.

## Metadata

Item instances use `amount`, `slot` and `info`. Shared item definitions use `weight`, `type`, `unique`, `useable`, `image` and `shouldClose`. Preserve a backpack's `info.backpackId` when moving it; generating a new ID disconnects it from its saved contents.

```lua
local info = { quality = 100, note = 'Issued equipment' }
local added = exports['qb-inventory']:AddItem(source, 'water_bottle', 1, false, info, 'example')
```

