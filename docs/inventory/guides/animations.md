# Animations

Edit `Config.InventoryAnimations` in `config/config.lua`. `Resource = 'auto'` detects `rpemotes` and `rpemotes-reborn`; set a resource name explicitly for a renamed installation.

## Actions

Opening, giving, receiving, ground pickup/drop, storing and taking items have configurable animation definitions. Native animations provide a fallback for unsupported emote names. Backpack transfers do not play the handover emote. Trunk searching uses a native loop until the trunk inventory closes.

## Opening progress

`Config.OpeningProgress` controls the opening progress bar independently. The shipped duration is 550 milliseconds; disable it with `enabled = false` or `duration = 0`.

```lua
OpeningProgress = {
    enabled = true,
    duration = 550,
    label = 'Opening inventory...',
},
```

## Compatibility

Existing emotes and player-state guards can suppress action animations. Verify configured emote names against your installed version. The resource does not require an external throw/place integration for nearby item giving.

