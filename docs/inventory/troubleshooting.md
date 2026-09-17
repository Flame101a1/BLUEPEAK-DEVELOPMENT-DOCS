# Troubleshooting


- **Nothing opens:** check the server console and client F8 console; confirm the folder is named `qb-inventory`, all manifest files were uploaded, dependencies started, and no second inventory is running. Restart the resource after replacing files.
- **Blank UI:** check F8 for JavaScript/CDN errors and verify client access to the browser-library hosts listed above.
- **Unknown `type` database column:** apply `install/upgrade.sql` to the correct database.
- **Rack missing:** confirm the exact job name is allowed, the player is seated in the vehicle, any duty requirement is met, and another player is not already using it.
- **Trunk option missing:** check qb-target, vehicle lock state, and distance from the trunk end of the vehicle.
- **Missing item images:** check the item's `image` field against `html/images`; filenames must match.
- **Animation missing:** check the RPEmotes resource name and configured emote names. Existing emotes and player-state guards can suppress action animations.

When reporting a problem, include reproduction steps, relevant F8/server errors, dependency versions, and whether it happens on foot, in a vehicle, or in a shop. Do not include database passwords or license keys.

## Release verification

Before enabling on a public server, test with two players: item transfers, shop payment, trunk and glovebox persistence, backpack persistence and nesting prevention, armor durability, protected-slot police/civilian access, weapon-rack job restrictions, and saving across a server restart. Local syntax or browser checks do not replace an in-game integration test.
