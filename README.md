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

### 1. Dynamic Aura Heatmap (Real-Time Rendering)
- **Tech Stack**: Google Maps Platform or Mapbox SDK.
- **How it works**: The placeholder Map screen will be replaced with an interactive map. Whenever a user submits a "Ground Truth Check-in", a POST request updates the crowd density index for that specific geolocation. A WebSocket or Firebase Snapshot listener will pull this data and dynamically intensify the glowing radius (Aura) over locations with high "Packed" reports.

### 2. Earning Aura Points (Secure Input)
- **Tech Stack**: Firebase Cloud Functions.
- **How it works**: When a user selects a location and status, the app securely sends this payload. A backend function verifies the input and automatically increments the user's "Aura Points" by +15 in the database. The "Hall of Fame" screen fetches and sorts the top users globally.

### 3. Geofencing & Anti-Spam (Data Integrity)
- **Tech Stack**: `geolocator` Flutter package.
- **How it works**: To prevent users from spoofing data (e.g., claiming the library is empty while sitting in their dorm), the app will check their device GPS coordinates upon submission. If they are not within a 50-meter radius of the reported facility, the check-in is rejected.

### 4. Campus Email Authentication
- **Tech Stack**: Firebase Authentication.
- **How it works**: To ensure the platform remains exclusive and troll-free, sign-ups will be restricted. Only users with a verified `@youruniversity.edu` email address will be able to create an account and access the leaderboard.

### 5. Smart Push Notifications
- **Tech Stack**: Firebase Cloud Messaging (FCM).
- **How it works**: Users can subscribe to specific locations. For example, *"Notify me when the Gym goes from Packed to Empty"*. The backend will monitor status changes and push real-time alerts to the user's device.

### 6. Temporal Decay Algorithm
- **Tech Stack**: Backend CRON jobs.
- **How it works**: Crowd data gets stale rapidly. A backend script will automatically degrade reports over time. If a location hasn't received a check-in for 45 minutes, its status will automatically reset to "Unknown" to prevent outdated information from misleading students.

---

*Designed and developed to ace the Campus Pulse E-Labs challenge.* 🚀
