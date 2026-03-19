# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-03-19

### Added
- **Sanctuary (Santuario)**: A personal space for your capybara companion.
- **Furniture & Shop**: Purchase cozy items (pillows, tables, bonsai) and unique backgrounds using earned currency.
- **Interactive Decor**: Drag and drop furniture to customize your sanctuary. Positions are saved automatically.
- **Cozy Furniture Renderer**: Stylized, vector-drawn furniture items for a consistent artistic look.
- **Heart Animations**: Tap the capybara to trigger delightful heart effects.
- **Global Localization**: Propagated sanctuary and shop support across all 12 languages.
- **Enhanced Filters**: More dramatic atmospheric filters for sanctuary backgrounds.

### Fixed
- **Startup Race Condition**: Resolved a fatal error where the app attempted to read the database before tables were fully created.
- **Database Migration v8**: Implemented robust, idempotent migrations for new catalog items.
- **Inventory Sync**: Optimized BLoC logic for instantaneous inventory and placement updates.
- **Build Errors**: Fixed several 'const' constructor and undefined variable errors in release builds.

## [1.0.0] - 2026-03-16

### Added
- **Initial Release**: The first official version of DopiGame is here!
- **Gamified Tasks**: Complete daily tasks to earn XP and level up.
- **Cozy Design System**: Custom "Cozy Theme" with warm colors, rounded borders, and relaxing aesthetics.
- **Capybara Tea Party**: Dynamic backgrounds featuring our favorite cozy capybaras.
- **Level System**: Progress through levels 1-10 with increasing XP requirements.
- **Task Categories**: specialized categories like Medical, Habit, Event, and Task, each with unique icons and XP rewards.
- **Full Localization**: Support for over 10 languages including Spanish, English, Arabic, Catalan, French, Portuguese, German, Italian, Chinese, Japanese, Ukrainian, and Bulgarian.
- **Profile Customization**: Options to change your username and avatar image.
- **Smart Notifications**: Automated reminders for task deadlines with timezone support.
- **Immersive Mode**: Full-screen experience on Android devices.
- **Clean Architecture**: Robust foundation based on SOLID principles and Clean Architecture.

### Fixed
- **Task Completion Persistence**: Resolved a bug where tasks would not disappear from the list or award XP correctly when checked.
- **Database Resilience**: Fixed an issue where data could be lost or reset upon application restart.
- **Notification Reliability**: Improved the notification service to prevent crashes on unsupported platforms.
- **Logging**: Implemented detailed debug logging for easier maintenance.

---

Made with ❤️ and 🍵 by the DopiGame Team
