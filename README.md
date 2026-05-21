# Neon District

A portable KDE Plasma global theme project for NixOS/KDE machines.

Dark fantasy-tech. Cyberpunk control room. Goblin-engineer energy. Dracula-adjacent neon color work.

## Target Components

- Custom application icons
- Desktop launcher overrides
- KDE color scheme
- Plasma style assets
- Konsole profile
- Wallpapers
- Splash and lock screen assets
- Cursor theme eventually
- Install and rollback scripts

## Rule

Nothing goes live without a rollback path.

<!-- NEON-DISTRICT-FIRST-PLAYABLE -->

# Neon District

Neon District is a portable KDE-first desktop identity system for RECON.

It is not just a theme. It is a full visual operating environment: a dark fantasy-tech control room, a cyberpunk workstation skin, a goblin-engineer dashboard, and a Dracula-adjacent neon system with a slight dystopian edge.

The goal is not decoration. The goal is identity, readability, and operational presence.

## Core Concept

Neon District should feel like a beautiful system with teeth.

It should support:

- KDE Plasma theming
- icon and cursor direction
- terminal and developer workflows
- wallpapers and visual atmosphere
- future RGB hardware synchronization
- future cross-platform expansion

This is the visual language layer. It defines intent before execution.

## Official Colorways

Neon District is the family name.

Official colorways currently include:

- `Neon District` as the original default palette and theme foundation
- `Neon District: CyberWire` as a cyan-heavy terminal, HUD, and netrunner-oriented variant

CyberWire is not a separate project. It is a second official Neon District colorway for command-line, intrusion-console, and heads-up-display styling.

## First Playable State

Current foundational files:

- `palettes/neon-district.json`
- `palettes/neon-district-cyberwire.json`
- `modes/cyberwire.json`
- `modes/recon.json`
- `exports/steelseries/scenes/neon-district-cyberwire.json`
- `exports/steelseries/scenes/neon-district-recon.json`
- `docs/ROADMAP.md`
- `docs/integrations/steelseries-rgb-sync-roadmap.md`

These files define:

- canonical colors and official colorways
- semantic mode roles
- hardware-agnostic RGB scene intent
- development phases
- repo boundaries

## Repo Boundary Rule

Do not merge this repo with SteelSeries_RGB.

Neon District owns:

- visual identity
- palettes
- modes
- scene intent
- KDE theme direction
- documentation

SteelSeries_RGB owns:

- hardware parsing
- device mapping
- dry-run rendering
- guarded RGB writes

The integration rule:

`Neon District authors intent. SteelSeries_RGB executes hardware.`

Work in one repo at a time.

Active Neon District repo:

`/mnt/storage/Cole/Projects/neon-district`

Future hardware integration repo:

`/mnt/storage/Cole/Projects/SteelSeries_RGB`

Do not modify SteelSeries_RGB until Neon District reaches First Playable State and is committed.

## Cross-Platform Goal

Linux/KDE is the primary target, but Neon District should eventually travel.

Future targets may include:

- Windows visual package references
- macOS adaptation notes
- VS Code theme
- terminal profiles
- browser start page
- wallpaper packs
- RGB scene exports for multiple hardware systems

The identity should survive the trip.
