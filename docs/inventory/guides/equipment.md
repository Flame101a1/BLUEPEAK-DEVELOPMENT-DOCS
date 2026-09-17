# Backpacks and equipment

## Backpacks

Current capacities are small: 50 slots / 50 kg; medium: 20 slots / 100 kg; large: 30 slots / 150 kg. Change these independently to match your economy.

```lua
["backpack_small"] = {
    slots = 15,
    weight = 30000
},
```

Using a backpack opens it beside the player's pockets. The backpack equipment slot is hidden in this edition; existing equipped-backpack data is retained. Backpacks cannot be inserted into other backpacks, including through swaps. Previously nested bags can be removed.

## Protected slot and armor

The bottom slot marked **6** supports normal owner use, moving, dropping, and giving. It is protected from ordinary player searches and transfers, not from administrative clears or external scripts that directly edit inventory data.

By default, jobs `police`, `sheriff`, `bcso`, and `fib`, and jobs with type `leo`, can access it during existing player searches. This exception does not grant a search command by itself.

Equipping armor moves one piece from a stack and tracks its durability independently. The vest slot remains visible beneath the inventory. Check for conflicting armor logic in other resources during integration.
