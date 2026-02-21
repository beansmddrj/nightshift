# Nightshift – Game Design Document

## 1. Vision

Nightshift is a stylized 2D underground car culture game focused on atmosphere,
reputation building, risk management, and player agency.

The game emphasizes:
- Japanese-inspired street scene culture
- Night meets and underground energy
- Reputation growth
- Risk vs reward tension
- Player skill influencing outcomes
- Strong vibe and aesthetic identity

This is NOT a racing simulator.
This is NOT an RNG spreadsheet game.
This is a culture-driven progression game with systems depth.

---

## 2. Core Pillars

1. Atmosphere First
   - Night environments
   - Neon lighting
   - Turbo spool audio cues (later)
   - Underground energy

2. Player Agency
   - Skill can overcome weaker builds
   - Risk decisions matter
   - Heat management creates tension

3. Progression
   - Reputation grows over time
   - Car builds evolve
   - Unlockable content

4. Expandability
   - Architecture must support:
     - More cars
     - More locations
     - More events
     - Multiplayer leaderboard (future)

---

## 3. Core Gameplay Loop (V1)

1. Start Night
2. Go to Meet
3. Participate in events
   - Pull
   - Stay
   - Leave
4. Gain Reputation and Cash
5. Heat increases over time
6. If Heat exceeds threshold → Police encounter
7. Escape or get Busted
8. End Night
9. Repeat

V1 goal: Fully playable loop within 60–90 seconds.

---

## 4. V1 Scope (Strict Limits)

V1 must include:

- Main Screen
- Meet Screen
- Pull Event
- Heat System
- Reputation System
- Save / Load
- Busted Screen

V1 must NOT include:

- Open world map
- Realistic physics
- Multiplayer
- 10+ cars
- Deep tuning UI
- NPC dialogue systems

Keep it small and finishable.

---

## 5. Data Model

### SaveData

```ts
type SaveData = {
  night: number;
  rep: number;
  heat: number;
  cash: number;
  car: CarStats;
};

type CarStats = {
  power: number;
  grip: number;
  reliability: number;
  boost: number;
};
Notes:

Heat resets each night.

Reputation persists.

Cash persists.

Car stats persist.

6. Systems Overview
Reputation System

Increases from successful events.

Decreases from losses.

Used to unlock higher-tier meets (future).

Heat System

Increases when staying at meet.

Increases after pulls.

Decreases slowly if leaving early.

If Heat exceeds threshold → Police encounter.

Pull System (V1 Simplified)

Basic skill-based mechanic (timing or reaction).

Car stats influence difficulty window.

Winning grants:

Reputation

Cash

Losing reduces reputation.

Police Encounter (V1 Simplified)

Triggered if heat >= threshold.

Simple escape skill check.

Failure → Busted.

7. Screens & Flow
Main Screen

Display:

Night

Reputation

Cash

Button:

Go To Meet

Save Game

Load Game

Meet Screen

Display:

Heat meter

Current car stats

Buttons:

Take Pull

Stay (increase heat)

Leave

Pull Screen

Skill interaction

Win/Lose result

Busted Screen

Message: “Busted”

Option to return to Main

8. Architecture Plan

Project structure:

nightshift/
  DESIGN.md
  core/           # TypeScript engine-agnostic systems
  game/           # Godot project
Hybrid Phase (Current)

Gameplay logic implemented in GDScript.

SaveData shape defined here.

TypeScript mirrors structures for future migration.

Future Phase (GodotJS)

Core logic moves to TypeScript.

GDScript replaced or minimized.

JSON SaveData remains consistent.

9. Future Expansion Roadmap

Phase 2:

Multiple meet locations

Car upgrade system

Unlockable build paths

Phase 3:

Walkable meet scene

NPC rivals

Deeper tuning

Phase 4:

Online leaderboard

Competitive modes

10. Design Rules

Do not add features unless V1 loop is complete.

Every feature must support:

Atmosphere

Player agency

Tension

Avoid RNG-heavy systems without skill influence.

Keep systems modular and scalable.

11. Definition of Done (V1)

The game is considered complete for V1 when:

Player can start a night.

Player can participate in at least one pull.

Heat increases over time.

Player can get busted.

Progress saves and loads correctly.

The loop is replayable.

No feature creep before this point.
