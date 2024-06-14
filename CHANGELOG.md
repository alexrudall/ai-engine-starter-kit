# Changelog

All notable changes to the AI::Engine project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
