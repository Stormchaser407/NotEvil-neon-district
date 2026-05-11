# SteelSeries RGB Sync Roadmap

This document defines the boundary between Neon District and SteelSeries_RGB.

The short version:

`Neon District = visual intent`

`SteelSeries_RGB = hardware execution`

Do not merge the repos.

## Why the Boundary Exists

Neon District is a portable identity system. It should be able to describe a visual world without caring which keyboard, mouse, monitor rail, or future goblin-powered toaster renders it.

SteelSeries_RGB is a hardware-control project. It should know the messy details:

- supported SteelSeries devices
- HID packet formats
- device zones
- dry-run rendering
- write safety
- permission checks
- hardware-specific limitations

If Neon District starts doing packet work, the theme repo becomes a swamp. If SteelSeries_RGB starts inventing style doctrine, the hardware repo becomes a mood board with USB privileges. Bad. No treats.

## Neon District Responsibilities

Neon District owns:

- canonical palette files
- mode definitions
- semantic color roles
- visual tone
- generic scene exports
- brightness guidance
- cross-platform identity
- documentation of intended behavior

Primary files:

- `palettes/neon-district.json`
- `modes/recon.json`
- `exports/steelseries/scenes/neon-district-recon.json`

## SteelSeries_RGB Responsibilities

SteelSeries_RGB owns:

- parsing exported Neon District scene JSON
- validating schema compatibility
- mapping generic zones to real device zones
- rendering dry-run previews
- logging intended actions
- blocking unsafe writes
- executing hardware writes only after explicit approval

Initial integration should be dry-run only.

## Generic Zone Model

Neon District may define generic zones like:

- `keyboard.base`
- `keyboard.alpha_keys`
- `keyboard.modifier_keys`
- `keyboard.navigation_keys`
- `keyboard.function_row`
- `keyboard.system_keys`
- `keyboard.active_layer`
- `mouse.body`
- `mouse.logo`
- `mouse.wheel`
- `mouse.dpi_indicator`

SteelSeries_RGB decides how those zones map onto actual devices.

Unsupported zones should degrade gracefully. Dry-run output should explain what was mapped, skipped, or approximated.

## First SteelSeries_RGB Integration Pass

When Neon District First Playable State is complete, switch repos to:

`/mnt/storage/Cole/Projects/SteelSeries_RGB`

Then implement:

1. scene file loader
2. JSON validation
3. semantic role extraction
4. generic zone parser
5. dry-run renderer
6. device capability report
7. no hardware writes

## Safety Rule

The first integration pass must not write to hardware.

Acceptable:

- parse JSON
- print intended effects
- print zone mappings
- show unsupported zones
- produce dry-run logs

Not acceptable yet:

- live keyboard writes
- live mouse writes
- background services
- auto-start integration
- systemd user services
- magical RGB daemon gremlin behavior

## Integration Contract

Neon District scene exports should remain:

- human-readable
- versioned
- portable
- hardware-agnostic
- strict enough for validation
- loose enough for future devices

SteelSeries_RGB should be allowed to reject invalid scenes loudly and clearly.

A failed dry-run should explain the problem like a competent technician, not like a haunted printer.
