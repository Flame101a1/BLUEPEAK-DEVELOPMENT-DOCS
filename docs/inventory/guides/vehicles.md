# Vehicle storage and weapon racks


Open the glovebox while seated in a vehicle. Trunks use the **Open trunk** qb-target interaction; Tab does not open trunks. Trunks have 40 slots and gloveboxes have 5. Class weight limits live in `config/vehicles.lua`.

```lua
TrunkModelOverrides = {
    ['adder'] = { weight = 40000 },
    ['police'] = { weight = 90000 },
},
```

Weapon racks appear **under the glovebox on the right** for `police`, `sheriff`, and `hp`. The default rack has 5 slots and a 25 kg limit, with no duty requirement. Only items whose shared definition has `type = 'weapon'` are accepted. Ammunition belongs in normal storage.

Vehicle storage is identified by plate. Vehicles sharing a plate share its storage. Rack access is checked against the player's current job, vehicle, and open inventory session on every transfer.
