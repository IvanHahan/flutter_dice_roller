# Dice Roller

A simple Flutter demo app built during Lecture 1. Tap the button to roll a dice and see a random face.

## Environment setup

To run this app locally you need Flutter plus a code editor and at least one platform toolchain (iOS and/or Android).

### 1. Flutter SDK

Install the Flutter SDK from the official site. It includes Dart, so no separate Dart install is needed.

- Download: https://docs.flutter.dev/get-started/install
- After installing, add `flutter` to your PATH and verify it works:

```bash
flutter --version
flutter doctor
```

### 2. Editor

Either editor works; VS Code has the most popular Flutter extension.

- **VS Code**: https://code.visualstudio.com
  - Install the **Flutter** extension from the marketplace (Dart is pulled in automatically).
  - Shortcut to open the terminal: <kbd>Ctrl</kbd>+<kbd>~</kbd> (macOS: <kbd>Cmd</kbd>+<kbd>J</kbd>).
- **Cursor** (VS Code fork, AI-powered): https://www.cursor.com
  - Same Flutter extension applies — search for "Flutter" in the Extensions panel.

### 3. iOS toolchain (macOS only)

Xcode is required to build and run iOS apps, and to use the iOS Simulator.

- Install from the Mac App Store: https://apps.apple.com/us/app/xcode/id497799835
- Accept the license and install the command-line tools:
  ```bash
  sudo xcodebuild -license accept
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  xcode-select --install
  ```

To open the iOS Simulator once Xcode is ready:

```bash
open -a Simulator
```

### 4. Android toolchain

Android Studio provides the Android SDK, emulators, and device support.

- Download Android Studio: https://developer.android.com/studio
- During setup, the Android SDK, platform tools, and emulator are installed automatically. Accept the default SDK location.
- First launch: accept the licenses with:
  ```bash
  flutter doctor --android-licenses
  ```

To create and run an Android emulator:

1. Open Android Studio → **Device Manager** (toolbar icon) → **Create Virtual Device**.
2. Pick a device definition (e.g. Pixel 7) and a system image, then click **Finish**.
3. Launch the emulator and confirm Flutter sees it:
   ```bash
   flutter devices
   ```

### 5. Verify everything

```bash
flutter doctor
```

Fix anything marked with `[✗]` before running the app. `[✓]` means the toolchain is ready.

### Running the app

```bash
flutter pub get
flutter run
```

Press <kbd>r</kbd> in the terminal for hot reload while the app is running.

## Topics covered

- Flutter / Dart project structure
- MaterialApp, Scaffold, Center, Container, BoxDecoration
- StatelessWidget vs StatefulWidget
- Custom widgets and named constructors
- Asset images
- State management with setState
- Gradients, colors, TextButton
- Variables, constants (var, final, const)
