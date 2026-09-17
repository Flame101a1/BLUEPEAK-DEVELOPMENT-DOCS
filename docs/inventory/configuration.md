# Configuration

## Configuration

All capacities use **grams**: `1000` = 1 kg. Restart the resource after changing configuration.

| Setting in `config/config.lua` | Purpose / shipped default |
| --- | --- |
| `MaxSlots`, `MaxWeight` | 40 regular slots, 120 kg |
| `OpeningProgress` | Enabled; 550 ms; editable label |
| `ProtectedSlot` | Physical inventory slot 41, activated with key 6 |
| `ProtectedSlotPoliceAccess` | Job names and job types allowed to search the protected slot |
| `UtilitySlots.armorItems` | Armor strength and allowed jobs |
| `UtilitySlots.armorRepairItems` | Durability restored by repair items |
| `UtilitySlots.backpackItems` | Slot count and capacity for each backpack item |
| `WeaponRack` | Job list, optional duty check, slots, capacity, and label |
| `TrunkTarget` | Target interaction enabled, label, and distance |
| `TrunkModelOverrides` | Trunk weight overrides by vehicle spawn name |
| `InventoryAnimations` | Emote resource, action definitions, and enable switch |
| `CashAsItem` | Physical cash synchronization |
| `InventoryDebug` | Verbose diagnostics; disabled by default |

## Controls

| Control | Action |
| --- | --- |
| Tab | Open pockets, nearby drop, or glovebox when seated |
| Z | Toggle hotbar |
| 1â€“5 | Use the corresponding pocket slot |
| 6 | Use the protected slot |
| Drag and drop | Move, stack, or swap items |
| Double-click | Use an item or open a backpack |
| Close / Escape | Close inventory |
| qb-target at an unlocked trunk | Open trunk storage |

FiveM saves custom keybindings per player; changes to defaults may require updating the player's keybinding settings.
