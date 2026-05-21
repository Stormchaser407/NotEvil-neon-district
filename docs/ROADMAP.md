# Neon District Roadmap

Neon District is a portable desktop identity system: part KDE global theme, part operator dashboard aesthetic, part RGB-aware visual language.

It is not just a theme. It is the visual operating doctrine for RECON.

## Official Colorway Direction

Neon District is the family.

Current official colorways:

- `Neon District` as the original default palette and theme foundation
- `Neon District: CyberWire` as the cyan-heavy terminal, HUD, and netrunner variant

CyberWire is a colorway inside Neon District, not a separate project line.

## Style North Star

Neon District should feel like:

- dark fantasy-tech
- cyberpunk control room
- goblin-engineer workstation
- Dracula-adjacent neon
- a beautiful system with teeth

The desktop should look alive, but not childish. It should feel powerful, readable, and slightly dangerous — like the machine has opinions and excellent cable management.

## Phase 1 — First Playable State

Goal: define the visual intent in clean, portable files.

Deliverables:

- `palettes/neon-district.json`
- `palettes/neon-district-cyberwire.json`
- `modes/cyberwire.json`
- `modes/recon.json`
- `exports/steelseries/scenes/neon-district-cyberwire.json`
- `exports/steelseries/scenes/neon-district-recon.json`
- `docs/ROADMAP.md`
- `docs/integrations/steelseries-rgb-sync-roadmap.md`
- README vision update

Success criteria:

- JSON validates.
- Files are human-readable.
- Files are Codex-readable.
- The original Neon District palette remains intact while official colorways can expand.
- No hardware writes.
- No SteelSeries_RGB repo changes.
- Neon District owns visual intent only.

## Phase 2 — KDE Theme Skeleton

Goal: begin turning visual intent into actual KDE components.

Target components:

- KDE global theme metadata
- Plasma color scheme
- Konsole profile
- Kvantum theme notes or starter files
- Aurorae/window-decoration direction
- wallpaper folder structure
- cursor and icon references

Rules:

- Prefer modular files.
- Keep generated assets separated from source intent.
- Keep palette names stable.
- Treat official colorways as extensions of Neon District, not forks of the project identity.
- Avoid hardcoding one machine-specific path into portable theme files.

## Phase 3 — Icon System

Goal: create a recognizable Neon District icon language.

Icon principles:

- high contrast
- readable at small sizes
- dark fantasy-tech silhouettes
- neon edge highlights
- subtle dystopian bite
- not generic vaporwave slop

Candidate categories:

- system
- folders
- apps
- dev tools
- OSINT tools
- media tools
- gaming tools
- command-board controls

## Phase 4 — RGB Export Layer

Goal: export visual intent to external hardware systems without merging repos.

Neon District will define:

- palette families and official colorways
- semantic roles
- modes
- scenes
- generic zones
- brightness guidance
- mood/state language

SteelSeries_RGB will execute:

- parsing
- validation
- device mapping
- dry-run preview
- guarded hardware writes

The boundary matters. Neon District is the architect. SteelSeries_RGB is the electrician. Do not make the architect crawl into the wall with a screwdriver unless the building is on fire.

## Phase 5 — SteelSeries_RGB Integration

Goal: switch to the SteelSeries_RGB repo only after Neon District First Playable State is committed.

Initial SteelSeries_RGB work:

- parse `exports/steelseries/scenes/*.json`
- validate scene structure
- map generic zones to Apex 9 Mini and Rival 3 Wireless capabilities
- add dry-run renderer
- show intended colors/effects without hardware writes
- require explicit approval before any write path

No hardware writes in the first integration pass.

## Phase 6 — Cross-Platform Expansion

Goal: make Neon District portable beyond KDE/NixOS.

Future targets:

- Linux/KDE primary
- Windows theme package references
- macOS visual adaptation notes
- VS Code theme
- terminal themes
- browser start page
- wallpaper packs
- RGB scene exports for additional devices

Cross-platform does not mean lowest-common-denominator. It means the identity survives travel.

## Current Rule

Work in one repo at a time.

Active repo:

`/mnt/storage/Cole/Projects/neon-district`

Do not modify:

`/mnt/storage/Cole/Projects/SteelSeries_RGB`

until First Playable State is complete and committed.
