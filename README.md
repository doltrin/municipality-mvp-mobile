<div align="center">

# 🏛️ Municipality MVP Mobile

### Native Flutter App for Smart City Services

[![Flutter](https://img.shields.io/badge/Flutter-3.38-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10-0175C2?style=for-the-badge&logo=dart)](https://dart.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.5-00D1B2?style=for-the-badge)](https://riverpod.dev)

**A native mobile experience for municipal services**

</div>

---

## 📱 Overview

Municipality MVP Mobile is an enterprise-grade Flutter application providing citizens with seamless access to municipal services. Built with clean architecture principles and modern Flutter best practices.

## ✨ Features

- **🏠 Home Dashboard** - Weather, quick services, active tasks, news
- **📋 Services Catalog** - Browse 50+ municipal services by category
- **📰 News & Events** - Latest announcements and alerts
- **👤 Profile Management** - Account settings, wallet, preferences
- **🌙 Dark Mode** - Full dark theme support
- **🤖 AI Assistant** - Integrated chatbot (coming soon)

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/      # App-wide constants
│   ├── extensions/     # Dart extensions
│   ├── theme/          # Design system (colors, typography, theme)
│   └── utils/          # Utility functions
├── features/
│   ├── home/           # Home screen feature
│   ├── services/       # Services catalog feature
│   ├── news/           # News & events feature
│   └── profile/        # Profile & settings feature
├── routing/            # GoRouter configuration
└── shared/
    ├── models/         # Shared data models
    └── widgets/        # Reusable UI components
```

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.38 |
| **Language** | Dart 3.10 |
| **State Management** | Riverpod 2.5 |
| **Navigation** | GoRouter 14 |
| **Icons** | Lucide Icons |
| **Animations** | Flutter Animate |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.10+
- Dart SDK 3.10+
- Android Studio / VS Code
- iOS Simulator or Android Emulator

### Installation

```bash
# Clone the repository
git clone https://github.com/doltrin/municipality-mvp-mobile.git

# Navigate to project
cd municipality-mvp-mobile

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 🎨 Design System

The app follows the **Solid Citizen Design System**:

- **Primary Color:** Indigo (#4F46E5)
- **Accent Color:** Sky Blue (#0EA5E9)
- **Typography:** Roboto with Material 3 scale
- **Touch Targets:** Minimum 44px (WCAG compliant)
- **Dark Mode:** Full OLED-friendly dark theme

## 📋 Enterprise Standards

- ✅ Clean Architecture (Feature-based)
- ✅ Strict Dart analysis (no warnings)
- ✅ Riverpod for state management
- ✅ GoRouter for declarative navigation
- ✅ Material 3 design system
- ✅ Accessibility (WCAG AA)
- ✅ Dark mode support
- ✅ Semantic versioning

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

<div align="center">

**Built with ❤️ using Flutter**

</div>
