# Changelog

All notable changes to the AI::Engine project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2024-06-27

### Added

- Add pricing for models & UI

## [0.2.0] - 2024-06-27

### Added

- Add chat UI to use OpenAI chat models

## [0.1.4] - 2024-06-24

### Fixed

- Fix release script to clean up previous build before release!

## [0.1.3] - 2024-06-24

- Debugging: Yanked

## [0.1.2] - 2024-06-14

### Fixed

- Trigger Threadable#ai_engine_on_message_update after Run#prompt_token_usage is set so that it can be broadcast to the UI.

## [0.1.1] - 2024-06-14

### Fixed

- Fix streaming so that each chunk triggers the Threadable#ai_engine_on_message_update callback.

## [0.1.0] - 2024-06-14

### Added

- Add Rails AI app for testing OpenAI Assistants called Storyteller
- Add ai-engine gem to manage assistants, threads, runs and messages
