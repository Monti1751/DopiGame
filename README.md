# 🐾 DopiGame - Your Cozy Task Companion

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean_Architecture-green?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

### Created by **Monti1751**

**DopiGame** is a gamified task manager designed to bring a touch of whimsy and comfort to your daily productivity. Transform your "To-Do" list into an adventure where completing tasks earns you XP, levels you up, and unlocks a more cozy experience.

---

## ✨ Features

*   **Gamified Productivity**: Earn XP and level up by completing your daily tasks.
*   **Whimsical Aesthetics**: Relaxing "Capybara Tea Party" backgrounds and soft, cozy UI design.
*   **Personalized Profile**: Customize your username and avatar to make the adventure yours.
*   **Smart Notifications**: Never miss a deadline with automated, timezone-aware reminders.
*   **Immersive Mode**: Focus entirely on your tasks with a full-screen, distraction-free interface.
*   **Multi-language Support**: Fully localized in English and Spanish.
*   **Clean Architecture**: Built with SOLID principles and Clean Architecture for a robust and maintainable codebase.

---

## 🛠️ Technical Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Local Database**: [sqflite](https://pub.dev/packages/sqflite)
- **Localization**: [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) (ARB files)
- **Notifications**: [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- **Timezone Handling**: [flutter_timezone](https://pub.dev/packages/flutter_timezone)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Latest Stable)
- Android Studio / VS Code
- Android SDK (API 35+)

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/DopiGame.git
    cd DopiGame
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the app**:
    ```bash
    flutter run
    ```

4.  **Build Release APK**:
    ```bash
    flutter build apk --release
    ```

### 📱 Installing the APK on Android

Once the build is complete, follow these steps to install the app on your device:

1.  **Locate the APK**: Navigate to `build/app/outputs/flutter-apk/app-release.apk`.
2.  **Transfer to Phone**: Send the file to your Android device via USB, email, or a cloud service.
3.  **Enable Unknown Sources**: On your Android device, go to **Settings > Security** (or **Settings > Apps > Special app access**) and enable **"Install unknown apps"** for your file manager or browser.
4.  **Install**: Open the `.apk` file on your phone and tap **Install**.
5.  **Enjoy!**: Open DopiGame and start your cozy quest.

---

## 🎨 Design System

DopiGame uses a custom "Cozy Theme" defined by:
- **Primary Color**: Soft pastel greens and browns.
- **Typography**: Smooth, readable fonts with custom scaling.
- **Components**: Rounded corners (16.0+ radius) and soft shadows.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ and 🍵 by the DopiGame Team
</p>
