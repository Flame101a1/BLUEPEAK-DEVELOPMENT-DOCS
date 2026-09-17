# Installation

## Requirements

Use a working QBCore FiveM server with OneSync and a MySQL/MariaDB database compatible with oxmysql. This is a QBCore resource; ESX compatibility is not provided.

| Resource | Purpose |
| --- | --- |
| `qb-core` | Player data, jobs, items, callbacks, and notifications |
| `oxmysql` | Database storage |
| `ox_lib` | Client helpers and text UI |
| `qb-target` | Trunks, vending machines, and drop interactions |
| `qb-weapons` | Weapon usage and attachments |
| `progressbar` | Opening and armor progress bars |
| `qb-smallresources` | Recommended for existing QB logging/consumable integrations |
| `qb-shops` | Required when using QB shop stock integration |
| `rpemotes` or `rpemotes-reborn` | Optional action animations; native fallbacks are available |

Dependencies are not bundled. The interface currently loads browser libraries and icon fonts from jsDelivr, unpkg, cdnjs, and Google Fonts. Clients need access to those hosts; this package is not an offline-bundled UI build.

## Installation

1. Back up the database, current inventory resource, and `qb-core/shared/items.lua`.
2. Stop the existing inventory resource. Install this folder as `resources/[qb]/qb-inventory`; do not run two inventory replacements together.
3. Install the dependencies above and configure the database connection for oxmysql.
4. For a **new installation**, import [qb-inventory.sql](downloads/qb-inventory.sql). It creates the `inventories` table with the backpack `type` column. It does not alter QBCore's existing `players` table.
5. For an **existing installation**, follow the upgrade section below instead of assuming a fresh import upgrades its schema.
6. Merge the entries from [install/items.lua](downloads/items.lua) into the existing QBCore shared item table. Copy the entries inside the example table, not its `return` wrapper. Update duplicate item definitions rather than adding a second copy.
7. Review `config/config.lua`, `config/vehicles.lua`, and `config/rarity.lua` for your server.
8. Start dependencies before this resource, then restart the server to refresh shared items.

Example startup order in `server.cfg` (adapt to your server's existing dependency order):

```cfg
ensure oxmysql
ensure ox_lib
ensure qb-core
ensure progressbar
ensure qb-target
ensure qb-weapons
# Optional, if installed:
# ensure rpemotes
ensure qb-inventory
ensure qb-smallresources
ensure qb-shops
```

`qb-target` is required by the shipped UI interactions even if `Config.TrunkTarget.enabled` is disabled. Keep `/assetpacks` support available for the supplied resource assets.

## Upgrading an existing server

- Keep a database backup before any migration. Preserve player inventory data and backpack metadata.
- If `inventories` already exists, run [install/upgrade.sql](downloads/upgrade.sql) to add its missing `type` column. The upgrade checks for that column and can be repeated.
- If upgrading from the old separate `gloveboxitems`, `stashitems`, and `trunkitems` tables, inspect and run [migrate.sql](downloads/migrate.sql) **once**, after creating/upgrading `inventories`. It assumes all three old tables exist and can conflict with identifiers already migrated. Keep the old tables until you have verified the migration.
- Preserve existing configuration values when merging an update. Do not change `ProtectedSlot` or utility slot offsets after players have stored items without migrating their data.
- Reducing a storage slot limit does not relocate existing items. Inspect legacy gloveboxes and trunks for occupied slots beyond the new 5/40 limits before release; move those items while their old slot limits are still active.
