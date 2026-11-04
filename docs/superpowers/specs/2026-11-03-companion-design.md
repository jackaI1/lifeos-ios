# LifeOS iOS companion

I want a quick phone view of the day's commitments and upcoming coursework without reopening the whole workspace. This read-only companion shows a schedule and unfinished deadlines, keeps its last successful download on disk, and explains when that copy is old or unavailable.

## Approach

The public LifeOS browser demo has no remotely callable schedule API: its routes run in a browser worker. I chose a small, public JSON demo API in this repository over pretending that the browser's routes are remotely available or connecting to private LifeOS. It contains fictional course examples, relative calendar days and local times in America/Toronto. Each successful download resolves those examples to absolute dates once; the persisted snapshot never moves forward when reopened offline. This is a separate companion demonstration, not synchronization with browser edits.

## Parts and constraints

- A Swift package owns decoding, validation, date resolution, HTTP reads, atomic disk storage, and loading state. XCTest exercises these boundaries without network dependencies.
- An iOS 17+ SwiftUI app presents native lists, large date heading, blue schedule markers, orange deadline markers, pull-to-refresh, retry, freshness and a source link. System text and colors support larger type and dark mode. No fixed row heights.
- Data loads immediately from cache, then refreshes when the app becomes active. Failed refreshes preserve the saved copy. Old snapshots are visibly dated and filtered against the actual current day; overdue unfinished deadlines remain visible.
- The JSON endpoint is raw.githubusercontent.com/jackaI1/lifeos-ios/main/demo-api/today.json. No accounts, writes, secrets, personal records or private endpoints.
- XcodeGen generates the Xcode project. GitHub Actions runs Swift tests, iOS XCTest, and an unsigned simulator build on macOS. Local tooling needs only Swift for core tests.
- No background refresh, notifications, editing, calendar permissions, or production backend in this version.

## Acceptance

Fresh download displays ordered commitments and deadlines; a restart with no network retains the original dates and last-update time. HTTP errors, malformed data, corrupt cache, cache-write failure, timezone boundaries, midnight and overlapping refreshes have useful outcomes. CI and the independent verifier must pass on merged main.
