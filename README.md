# QC Visualization - Power BI dashboard (demo with fake data)

A Power BI dashboard that tracks **P&ID inconsistencies** from a SmartPlant P&ID (SPPID)
database. It shows the current number of inconsistencies and how they change over time,
with slicers for inconsistency type, unit, and drawing, and a table you can export.

All data in this repository is **fake** (random IDs, made-up drawing and unit names).

## Pages
- **Current Overview** - current number of inconsistencies, filters by type / unit / drawing
- **History and Trends** - daily snapshots and trend over time
- **Table** - detailed list of inconsistencies for extraction

## Data model
| Table | Content |
|---|---|
| `INCONSISTENCY_FACT` | current inconsistencies |
| `INCONSISTENCY_SNAPSHOT_FACT` | one copy of the list per day, for history |
| `DRAWING_DIM` | drawings and their unit |
| `INCONSISTENCY_TYPE_DIM` | inconsistency types |
| `CALENDAR_DATE` | date table (DAX) |

Both fact tables relate to `DRAWING_DIM` (drawing) and `INCONSISTENCY_TYPE_DIM` (type).

## Files
- `fake_data/` - the four CSV files the dashboard reads
- `power_query_fake_source.m` - Power Query code that loads the CSV files

## How to use
1. Copy the `fake_data` folder to your PC, for example `C:\QC_Fake_Data`.
2. In Power BI Desktop set the `DataFolder` parameter to that folder, then refresh.
