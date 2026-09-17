# Client functions

Client exports support presentation and local checks. Perform authorization and item grants on the server.

## HasItem

Checks the local player's items and available equipped-backpack data.

```lua
exports['qb-inventory']:HasItem(items, amount)
```

| Parameter | Type | Description |
| --- | --- | --- |
| `items` | `string` or `table` | Item name, list of item names, or item-name-to-quantity mapping |
| `amount` | `number?` | Required quantity when using an item name or list |

**Returns:** boolean.

### Examples

```lua
local hasRadio = exports['qb-inventory']:HasItem('radio', 1)

-- Use a fresh table: the current client implementation mutates table arguments
-- as requirements are satisfied. Avoid reusing this table afterward.
local hasSupplies = exports['qb-inventory']:HasItem({
    water_bottle = 2,
    bandage = 1,
})
```

The check uses individual matching stacks rather than aggregating a required quantity across multiple stacks. Do not use this local result as proof for a server reward or transaction.

## Opening the interface

Use the normal inventory keybinding or `ExecuteCommand('openInv')` for the ordinary opening path. Custom stash and shop opening belongs in a server integration using [OpenInventory](server.md#openinventory) or [OpenShop](server.md#openshop).

There is no exported client `OpenInventory` function in this resource.
