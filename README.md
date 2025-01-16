# Anim AI - AI-Powered Photo Editor

Anim AI is a sophisticated mobile application built with Flutter that provides AI-powered photo editing capabilities. The app features a modern UI, responsive design, and seamless user experience across both Android and iOS platforms. For more information, please refer to the [Project Documentation](https://aeolian-bear-431.notion.site/Anim-AI-Documentation-17cd6108264280d3a7a7e441aa086017).

**Package Name (Android):** `com.animai.app`\
**Package Name (iOS):** `com.animai.ios`

## Environment

- **Flutter Version:** Channel stable, 3.27.1
- **Dart SDK Version:** 3.6.0 (stable)

## 📱 Features

- 🎨 AI-powered photo editing
- 🖼️ Multiple AI model support
- 💎 Premium subscription features
- 📱 Responsive design for phones and tablets
- 🌍 Internationalization support
- 🎯 Gesture-based editing controls
- 🔒 Secure local storage
- 🎉 Modern UI with animations

## 🏗️ Project Structure
```
lib/
├── core/                   # Core functionality
│   ├── app/                # App initialization
│   ├── config/             # App configuration
│   ├── constants/          # App-wide constants
│   │   ├── assets/         # Asset path management
│   │   ├── colors.dart     # Color definitions
│   │   └── typography.dart # Typography system
│   ├── services/           # Core services
│   ├── styles/             # Global styles
│   └── utils/              # Utility functions
│
├── src/                    # Source code
│   ├── common/             # Shared components
│   │   └── widgets/        # Common widgets
│   │
│   └── features/           # App features
│       ├── home/           # Home screen
│       ├── editor/         # Image editor
│       └── subscription/   # Subscription management
│
└── generated/              # Generated files
```

## 🛠️ Technical Stack

- **State Management**: 
  - Flutter Riverpod
  - Flutter Bloc
- **UI Components**:
  - flutter_screenutil
  - flutter_svg
  - gap
- **Storage**:
  - shared_preferences
  - path_provider
- **Image Processing**:
  - image_picker
  - crop_your_image
- **Notifications**:
  - flutter_local_notifications
- **Other**:
  - toastification
  - intl
  - freezed

## 🎯 Architecture

The project follows Clean Architecture principles with a feature-first organization:

1. **Core Layer**
   - Contains app-wide utilities, constants, and services
   - Manages base configurations and theme
   - Handles platform interactions

2. **Feature Layer**
   - Each feature is self-contained
   - Follows BLoC pattern for state management
   - Includes presentation, domain, and data layers

3. **Common Layer**
   - Shared widgets and layouts
   - Reusable components
   - Common utility functions


## 🚀 Building Release Version

### Use the build script:

```bash
./build_release.sh
```

## 📲 Development Testing

#### Connect your device enable usb debugging and run the following command, this will directly run the app on that device:

```bash
flutter clean
flutter pub cache repair
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Documentation
- [Project Documentation [Notion Link]](https://aeolian-bear-431.notion.site/Anim-AI-Documentation-17cd6108264280d3a7a7e441aa086017)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Riverpod](https://riverpod.dev/)
- [Flutter Bloc](https://bloclibrary.dev/)

## 👥 Authors

- [Vishal Balani](https://github.com/vishalbalani)
