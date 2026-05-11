<div align="center">

<img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Hacker%20News-%23FF6600.svg?style=for-the-badge&logo=y-combinator&logoColor=white" />
<img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=for-the-badge" />
<img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />

<br /><br />

```
██╗  ██╗███╗   ██╗    ██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗
██║  ██║████╗  ██║    ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
███████║██╔██╗ ██║    ██████╔╝█████╗  ███████║██║  ██║█████╗  ██████╔╝
██╔══██║██║╚██╗██║    ██╔══██╗██╔══╝  ██╔══██║██║  ██║██╔══╝  ██╔══██╗
██║  ██║██║ ╚████║    ██║  ██║███████╗██║  ██║██████╔╝███████╗██║  ██║
╚═╝  ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝
```

### *Read what matters. Built with Flutter.*

<br />

[**Live Demo**](#) · [**Download APK**](#) · [**Report Bug**](../../issues) · [**Request Feature**](../../issues)

<br />

</div>

---

## 🌑 Overview

**HN Reader** is a high-performance, premium Hacker News client built entirely with **Flutter**. It brings the full Hacker News experience to Android, iOS, and Web — wrapped in a refined dark aesthetic with smooth animations, real-time data, and deeply nested comment threading.

> No ads. No clutter. Just the stories that matter.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🌑 **Premium Dark Theme** | Custom high-contrast dark UI with DM Serif Display + Instrument Sans typography |
| ⚡ **Real-time Data** | Powered by the official Firebase Hacker News REST API |
| 🧵 **Nested Comments** | Recursive comment threading with lazy loading for deep discussions |
| 🚀 **Instant Launch** | Background engine pre-loading — zero wait time on web |
| 📱 **Cross-platform** | Seamless experience across Android, iOS, and Web |
| 🔙 **Browser History** | Full back/forward navigation support on Web |
| ✨ **Shimmer Loading** | Elegant skeleton loaders while content fetches |
| 🗂️ **Provider State** | Clean, scalable state management with the Provider package |

---

## 📸 Preview

<div align="center">

| Home Screen | Detail Screen |
|---|---|
| Top stories with scores, authors & comment counts | Full story + recursively threaded comments |

> *Dark editorial aesthetic — because reading should feel premium.*

</div>

---

## 🛠️ Tech Stack

```
Flutter ─────────────────── Cross-platform framework
├── Provider ────────────── State management
├── http ────────────────── Network layer (HN Firebase API)
├── Google Fonts ────────── DM Serif Display + Instrument Sans
└── Flutter Shimmer ─────── Loading skeleton animations

Web Layer
├── Custom HTML5/CSS3 ───── Landing page
└── JS Engine Bridge ─────── Flutter ↔ Web communication
```

---

## 🌐 API

This app uses the **official Hacker News Firebase API** — no auth, no keys, no limits.

```dart
// Base URL
const _base = 'hacker-news.firebaseio.com';

// 1. Fetch top story IDs  →  returns List<int>
Uri.https(_base, '/v0/topstories.json')

// 2. Fetch individual item (story or comment)
Uri.https(_base, '/v0/item/$id.json')

// Comment threading: recursively resolve item.kids[]
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0` (latest stable recommended)
- Android Studio **or** VS Code with Flutter extension
- Chrome / Edge for web testing

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/yourusername/hacker_news01.git
cd hacker_news01

# 2. Install dependencies
flutter pub get

# 3a. Run on Web
flutter run -d chrome

# 3b. Run on Android (device or emulator)
flutter run -d <device-id>

# 3c. Build release APK
flutter build apk --release
```

---

## 📁 Project Structure

```
hacker_news01/
│
├── lib/
│   ├── models/
│   │   ├── story.dart          # Story data model
│   │   └── comment.dart        # Comment data model
│   │
│   ├── services/
│   │   └── hn_service.dart     # HN API calls (topstories + items)
│   │
│   ├── providers/
│   │   └── story_provider.dart # State management with Provider
│   │
│   ├── screens/
│   │   ├── home_screen.dart    # Stories list view
│   │   └── detail_screen.dart  # Story + nested comments
│   │
│   ├── widgets/
│   │   ├── story_tile.dart     # Individual story row widget
│   │   ├── comment_tile.dart   # Recursive comment widget
│   │   └── shimmer_loader.dart # Loading skeleton
│   │
│   └── main.dart
│
├── web/
│   └── index.html              # Custom landing page + JS app bridge
│
├── android/
├── ios/
└── pubspec.yaml
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0                  # HTTP networking
  provider: ^6.1.2              # State management
  google_fonts: ^6.1.0          # DM Serif Display, Instrument Sans
  flutter_shimmer: ^3.0.0       # Shimmer loading effects
  html: ^0.15.4                 # Parse HN comment HTML
  flutter_html: ^3.0.0-beta.2   # Render HTML comments in Flutter
```

---

## 🗺️ Screens

### 🏠 Home Screen
- Fetches top story IDs from `topstories.json`
- Loads item metadata concurrently for each row
- Displays: **title**, **domain**, **score**, **author**, **age**, **comment count**
- Shimmer skeleton shown while loading

### 📄 Detail Screen
- Shows full story metadata + external link
- Parses the `kids[]` array to load first-level comments
- Recursively renders child comments with indent-based threading
- Lazy-loads deep comment branches on demand

---

## 🤝 Contributing

Contributions are welcome! Here's how:

```bash
# 1. Fork the repo
# 2. Create your feature branch
git checkout -b feature/AmazingFeature

# 3. Commit your changes
git commit -m 'Add AmazingFeature'

# 4. Push to the branch
git push origin feature/AmazingFeature

# 5. Open a Pull Request
```

---

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details.

---

<div align="center">

Built with ❤️ and ☕ by **[Nishant](https://github.com/yourusername)**

*If this helped you, a ⭐ on the repo would mean the world!*

<br />

<img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat-square&logo=Flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=flat-square&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/Firebase-%23039BE5.svg?style=flat-square&logo=firebase" />

</div>
