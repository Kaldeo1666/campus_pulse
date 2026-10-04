# Campus Pulse 📍

> A live "how crowded is it right now" telemetry app for your campus, featuring real-time heatmaps, smart nudges, and gamified check-ins.

![Campus Pulse UI Overview](https://img.shields.io/badge/UI-Premium_Glassmorphism-6C63FF?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white)

Nobody likes walking to a packed mess, a full library floor, or a long canteen queue, only to find out when they get there. **Campus Pulse** solves this by providing live crowd analytics, allowing students to make informed decisions and saving everyone's time.

---

## ✨ Features

- **Live Crowd Radar**: Check real-time crowd levels (Empty / Okay / Packed) for key campus locations like the Mess, Library floors, Canteen, Gym, and Labs.
- **Smart Nudges**: Receive actionable, dynamic recommendations like *"Central Library 2nd Floor is less crowded right now! Go now!"*
- **Tactile Check-In (Telemetry)**: Report how busy a spot is with a single tap using a buttery smooth, satisfying UI.
- **Aura Heatmap**: A visual, interactive campus heatmap overlaid with live crowd density data.
- **Gamification & Leaderboard**: Earn **Pulse Points** and maintain **Hot Streaks** for contributing accurate data. Climb the rankings and compete with peers!

---

## 🎨 Design & Aesthetics

The application was built from the ground up to feature a cutting-edge, startup-grade design:
- **Deep Dark Glassmorphism**: A sleek `#0F1115` dark background paired with neon accents.
- **Fluid Micro-Animations**: Powered by `flutter_animate`, components slide, shimmer, and breathe to make the interface feel alive.
- **Custom Typography**: Utilizes the modern `Outfit` font for a bold, premium typographic hierarchy.

---

## 🚀 How to Run & Install

### Option 1: Install the APK (Android)
If you simply want to test the app on an Android device:
1. Navigate to the `build/app/outputs/flutter-apk/` directory in this repository (or download it directly if provided in the release section).
2. Transfer the `app-release.apk` file to your Android device.
3. Tap the file to install (you may need to allow "Install from Unknown Sources" in your settings).

### Option 2: Build & Run locally (Developers)
To run the app from the source code, you'll need the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Kaldeo1666/campus_pulse.git
   cd campus_pulse
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```
   *(Select your target device: Android Emulator, iOS Simulator, Chrome, or Windows/macOS Desktop)*

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: Dart
- **Key Packages**:
  - `flutter_animate`: For buttery smooth entrance and state animations.
  - `google_fonts`: For dynamic typography (`Outfit`).

---

## 🔮 Future Scope & Backend Architecture

Since this is currently a high-fidelity frontend prototype, here is the roadmap for how the dynamic features will be fully functional once connected to a backend (e.g., **Firebase** or **Supabase**):

### 1. Dynamic Aura Heatmap
- **How it will update**: The heatmap will integrate with **Google Maps Platform** or **Mapbox SDK**.
- **Data Pipeline**: Whenever a user submits a "Ground Truth Check-in" from the Report screen, a POST request will be sent to the database updating the crowd density index for that specific geolocation.
- **Rendering**: The heatmap layer on the Map screen will pull this real-time density data via a WebSockets or Firebase Snapshot listener, dynamically intensifying the glowing radius (Aura) over locations with high "Packed" reports.

### 2. Earning Aura (Pulse) Points
- **Taking Input**: The "Check-in" screen securely captures the user's location via GPS (to prevent spoofing) and their selected crowd status.
- **Updating Score**: Upon clicking "Broadcast Intel", a backend cloud function will verify the input and automatically increment the user's "Aura Points" by +15 in the `users` database table.
- **Leaderboard Sync**: The "Hall of Fame" screen will fetch the top 15 users globally from the database, ordering them by their total Aura points in descending order.

---

*Designed and developed to ace the Campus Pulse E-Labs challenge.* 🚀
