# LifeOS Companion Implementation Plan

> Execute inline using superpowers:executing-plans. The owner explicitly requested autonomous implementation and merge, with no questions.

**Goal:** A working public SwiftUI companion showing today's schedule and deadlines with disk caching.
**Architecture:** A Foundation-only Swift package handles the public demo feed and dated snapshots. A native SwiftUI shell uses the same core; XcodeGen and macOS CI validate the iOS app.
**Tech Stack:** Swift 6, SwiftUI, XCTest, URLSession, XcodeGen, GitHub Actions.
**Spec:** docs/superpowers/specs/2026-11-03-companion-design.md

## Global Constraints

iOS 17+, fictional public data only, no private connections, no secrets. Preserve existing behavior (the initial repo has no app or tests). Never push main. Keep README plain and first-person. Cache dates must not slide on offline restart.

## Review Focus

- Timezone/day boundaries, including daylight saving, must preserve local event times.
- Old and corrupt cache must not masquerade as fresh schedule data.
- Bad responses and failed disk writes must leave the current display usable.
- Concurrent refresh must not overwrite newer data with older results.
- Empty lists and first offline launch must offer a useful retry state.

### Task 1: Core data and offline loading

Files: Package.swift, Sources/LifeOSCore/{DemoFeed,SnapshotCache,CompanionStore}.swift, Tests/LifeOSCoreTests/*, demo-api/today.json.
Interfaces: DemoFeed.snapshot(at:) -> Snapshot; Snapshot.events(on:), pendingDeadlines; SnapshotCache.read/write; CompanionStore.restore/refresh.
- [ ] Write XCTest examples for resolution, filtering, validation, real disk roundtrip, HTTP errors, cache fallback and recovery.
- [ ] Run swift test and observe missing implementation failures.
- [ ] Implement the core with injected network transport and clock, preserving dated snapshots and serial refresh.
- [ ] Run the full swift test suite and commit.

### Task 2: Native app and macOS build

Files: App/*, project.yml, .github/workflows/ios.yml, scripts/ci-ios.sh, README.md, docs/design.md.
Interfaces: the app imports LifeOSCore and observes CompanionStore. CI compiles the same source and XCTest files as iOS framework and test targets.
- [ ] Build a native Today screen with schedule, deadlines, refresh, source and offline status.
- [ ] Add XcodeGen configuration, simulator XCTest and unsigned build CI.
- [ ] Document how to use and test it, API limitations and dated-cache behavior.
- [ ] Run local package tests and generated project validation, then request whole-branch review.
- [ ] Fix material findings, push branch, create PR, watch CI, rebase if needed, squash merge, watch main CI and run independent Sol verification until PASS.
