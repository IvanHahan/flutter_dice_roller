# Lecture 1 — Flutter Fundamentals & Dice Roller App

## 1. What is Flutter?

Flutter is an open-source UI framework by Google for building cross-platform applications from a single codebase. It targets:

- **Mobile** — Android, iOS
- **Desktop** — macOS, Windows, Linux
- **Web** — CanvasKit renderer (since Flutter 3.29 the legacy HTML renderer is removed)

Flutter is **not** a programming language. Flutter apps are written in **Dart**.

### Why Flutter vs alternatives?

- **Native (Swift/Kotlin):** you maintain two separate codebases
- **React Native:** bridges JS to native widgets — Flutter renders its own pixels via the **Impeller** engine, giving consistent look across platforms and better performance
- **Google ecosystem:** seamless integration with Firebase, Cloud, etc.
- **Single codebase** for mobile + desktop + web

> **2026 update:** Since Flutter 3.44, Material and Cupertino design libraries are being decoupled from the core framework into standalone packages (`material_ui`, `cupertino_ui`). The in-framework versions are frozen and will be deprecated in the next stable release. This change enables faster iteration on design widgets without waiting for Flutter's release cycle.

---

## 2. What is Dart?

Dart is the programming language used by Flutter. Key characteristics:

| Trait | Detail |
|---|---|
| Type system | **Strictly typed** — all types checked at compile time |
| Compilation | **AOT** (ahead-of-time) to native ARM/x86 for mobile/desktop; **JIT** during dev (hot reload); can also compile to JavaScript/WebAssembly for web |
| Paradigm | Object-oriented — every value is an object (all types inherit from `Object`) |
| Null safety | Sound null safety since Dart 2.12 — types are non-nullable by default; `?` marks a type as nullable |
| Modern features (Dart 3+) | Records, patterns, sealed classes, switch expressions, class modifiers |

### Dart 3+ highlights (since May 2023)

Dart 3.0 introduced major features you'll encounter:

- **Records** — anonymous, immutable data structures like tuples. Return multiple values from a function:
  ```dart
  (int, String) result = (42, "hello");
  ```
- **Patterns** — destructure and match values; used in switch cases, variable declarations, and more
- **Sealed classes / class modifiers** — `sealed`, `base`, `interface`, `mixin class` let you control how a class can be extended or implemented
- **Switch expressions** — use `switch` as an expression, not just a statement
- **Private field promotion** (Dart 3.2+) — private final fields can be type-promoted like public ones

> **For this course:** we start with the basics. Records and patterns will appear in later lectures.

---

## 3. Setting up the environment

### Prerequisites

| Tool | Purpose |
|---|---|
| **VS Code** (recommended) or Android Studio | IDE |
| **Flutter SDK** | Framework + CLI |
| **Android Studio** (Android only) | Android SDK, emulator, command-line tools |

### Installation steps

1. **Install VS Code** and the **Flutter extension**
2. Open VS Code → press `F1` / `Ctrl+Shift+P` → run **Flutter: New Project** (this installs Flutter if missing, or use `flutter create` from terminal)
3. **Android only:** Launch Android Studio → **SDK Manager** → install latest Android API + SDK Tools (Android Emulator, Android SDK command-line tools)
4. **AVD Manager** → create an emulator (e.g., Pixel device)
5. Start the emulator — leave it running to avoid cold boots

> **2026 update:**
> - **iOS/macOS:** The Flutter 3.44 default for iOS/macOS dependency management is now **Swift Package Manager** instead of CocoaPods. The CLI handles this automatically.
> - **Android:** The Flutter Gradle plugin uses a declarative Kotlin-based approach (not the old Groovy `apply` script). Your generated project is already set up correctly.
> - **Windows/Linux users:** You can only build for Android on Windows. iOS development requires macOS.

---

## 4. Project structure

```
flutter_application_1/
├── lib/                 # Your Dart code — main entry point
├── android/             # Android platform files
├── ios/                 # iOS platform files
├── macos/               # macOS (desktop) platform files
├── linux/               # Linux platform files
├── web/                 # Web platform files
├── windows/             # Windows desktop platform files
├── test/                # Unit/widget tests
├── assets/              # Your images, fonts, etc.
├── pubspec.yaml         # Project metadata + dependencies
├── analysis_options.yaml # Linter configuration
└── .dart_tool/          # Auto-generated, don't touch
```

### Key files

- **`pubspec.yaml`** — project name, version, SDK constraint, dependencies, asset declarations
- **`analysis_options.yaml`** — configures the Dart analyzer and linter
- **`lib/main.dart`** — the app's entry point

---

## 5. Your first app — `main()` and `runApp()`

Every Flutter app starts from the `main()` function:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    ),
  );
}
```

### The widget tree

```
MaterialApp
  └── Scaffold
       └── Center
            └── Text("Hello World")
```

- `main()` — entry point, called automatically by Dart
- `runApp()` — takes the **root widget** and renders it on screen
- `MaterialApp` — convenience widget that wraps common Material Design widgets (theme, navigation, etc.)
- `Scaffold` — provides the basic Material Design layout structure (app bar, body, drawer, etc.)
- `Center` — centers its child
- `Text` — displays a string

### `const` optimization

Dart shows blue underlines suggesting where `const` can be added. `const` means the widget is created at **compile time** and reused — less memory allocation at runtime. Always add `const` when possible.

> **2026 update:** Material 3 is the default design language since Flutter 3.16. You don't need `useMaterial3: true` — it's already default. Material 3 affects the visual style of buttons, text themes, color schemes, and many widgets. The screenshots in older tutorials may look different from what you see.

---

## 6. Formatting and trailing commas

Dart has a convention: add a **trailing comma** after the last argument to trigger automatic multi-line formatting:

```dart
// Without trailing comma — everything on one line
TextButton(onPressed: rollDice, child: const Text('Roll'));

// With trailing comma — auto-formats to multi-line
TextButton(
  onPressed: rollDice,
  child: const Text('Roll'),
);
```

Then run **Format Document** (`Shift+Alt+F` in VS Code) to clean up indentation.

---

## 7. Types and variables in Dart

### Variable declaration styles

```dart
var name = 'Bob';                // Mutable, type inferred as String
String name = 'Bob';             // Explicit type
String? nullableName;            // Nullable — defaults to null
final String name = 'Bob';       // Runtime constant — can't be reassigned
const String name = 'Bob';       // Compile-time constant — can't be reassigned
```

| Keyword | Mutable? | Set at | Use case |
|---|---|---|---|
| `var` / explicit type | Yes | Runtime | Regular variables |
| `final` | No | Runtime | Values computed at runtime but fixed after |
| `const` | No | Compile time | Literals, nested const objects |

### Type hierarchy

```
Object (base class for everything)
  ├── num
  │   ├── int
  │   └── double
  ├── String
  ├── bool
  ├── Widget (Flutter)
  └── ...
```

> **2026 update (Dart 3+):**
> - `Object?` is the top type (nullable). `Never` is the bottom type.
> - Dart 3.2+ allows **private final field promotion** — a private field can be promoted to a non-nullable type if it's `final` and not overridden.
> - Use `final` by default, change to `var` only if you need to reassign.

---

## 8. Styling with Container, BoxDecoration, gradient

### Adding a gradient background

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.yellow, Colors.green],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: const Center(
    child: Text('Hello World'),
  ),
)
```

- `Container` — a general-purpose widget for layout and styling
- `BoxDecoration` — configures background, border, shadows, gradient
- `LinearGradient` — creates a color gradient
- `Alignment` — controls direction (`topLeft` → `bottomRight`, etc.)

---

## 9. Extracting a custom widget

### Step 1: Create a StatelessWidget

```dart
class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.gradientColors});

  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}
```

### Named constructor

```dart
class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.gradientColors});

  const MyContainer.yellowGreen({super.key})
      : gradientColors = const [Colors.yellow, Colors.green];

  final List<Color> gradientColors;
  // ...
}
```

Named constructors provide convenient presets. The redirect syntax (`: gradientColors = ...`) initializes `final` fields before the constructor body runs.

### Key points

- Always use `super.key` — the framework uses keys to identify widgets
- Always add `const` to your constructors when possible — enables widget reuse
- Always use `required` for mandatory named parameters
- Use `BuildContext context` (explicit type) in the `build` method

---

## 10. File conventions

| What | Convention | Example |
|---|---|---|
| File names | `snake_case` (lowercase, underscore-separated) | `dice_roller.dart`, `my_container.dart` |
| Classes | `PascalCase` | `DiceRoller`, `MyContainer` |
| Variables, methods | `camelCase` | `rollDice()`, `gradientColors` |

### Importing your own files

```dart
import 'package:flutter_application_1/my_container.dart';
import 'package:flutter_application_1/dice_roller.dart';
```

Replace `flutter_application_1` with your project name (from `pubspec.yaml`).

---

## 11. Adding assets (images)

### 1. Create an `assets/images/` folder in your project root
### 2. Add images there (e.g., `dice-1.png` … `dice-6.png`)
### 3. Declare the directory in `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

Note: use **forward slashes** — they work on all platforms. Backslashes (`\`) will break on macOS/Linux.

### 4. Use in code:

```dart
Image.asset('assets/images/dice-3.png');
```

**Directory-level declaration** (`- assets/images/`) includes every file in that directory. Avoid listing files individually.

> **2026 note:** You can also use `Image.network()` for URLs and `Image.file()` for local files.

---

## 12. StatefulWidget and setState

### When to use StatefulWidget

If your widget needs to change what it displays over time (user interaction, timer, data change), use `StatefulWidget` + `State`.

### Pattern

```dart
class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  final _random = Random();
  var _diceRollNumber = 1;

  void rollDice() {
    setState(() {
      _diceRollNumber = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/dice-$_diceRollNumber.png'),
        const SizedBox(height: 50),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll the dice'),
        ),
      ],
    );
  }
}
```

### How it works

| Step | What happens |
|---|---|
| `setState(() { ... })` | Tells Flutter: "data changed, rebuild" |
| Flutter calls `build()` again | Returns a new widget tree with the updated number |
| Only the changed parts re-render | Flutter is smart — it diffs the old and new trees |

### Best practices

- **Single `Random` instance** — don't create `Random()` on every roll. Store it as a `final` field
- **Private fields** — prefix with `_` to indicate internal state
- **Use `var` for state fields** — they get reassigned inside `setState`, so `final` won't work
- **Use `final` for everything else** — `_random` never changes, so it's `final`

---

## 13. TextButton and styling

```dart
TextButton(
  onPressed: rollDice,              // callback — no parentheses
  style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 28),
  ),
  child: const Text('Roll the dice'),
)
```

- `onPressed` — function to call when tapped. Pass the **function reference** (`rollDice`), not its result (`rollDice()`)
- `styleFrom` — convenience constructor for `ButtonStyle`
- In Material 3, `TextButton` uses a different color scheme than Material 2. If you want a filled button, use `FilledButton` or `ElevatedButton` instead

---

## 14. Final app structure

```
lib/
├── main.dart            # Entry point — MaterialApp + Scaffold
├── my_container.dart    # StatelessWidget — gradient background
└── dice_roller.dart     # StatefulWidget — dice image + button
```

### `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: MyContainer.yellowGreen(),
      ),
    ),
  );
}
```

---

## 15. Testing

A basic widget test:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/my_container.dart';

void main() {
  testWidgets('Dice roller responds to tap', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: MyContainer.yellowGreen()),
    ));

    expect(find.text('Roll the dice'), findsOneWidget);
    await tester.tap(find.text('Roll the dice'));
    await tester.pump();
    expect(find.text('Roll the dice'), findsOneWidget);
  });
}
```

---

## 16. What's next?

This lecture covered the absolute fundamentals. Upcoming topics:

- **Navigation & routes** — push, pop, named routes
- **Forms & input** — TextField, Form validation
- **HTTP & APIs** — fetching data from the internet
- **State management** — Provider, Riverpod vs setState
- **Dart 3 features** — records, patterns, sealed classes, switch expressions
- **Custom painting & animations**
- **Platform channels** — calling native Swift/Kotlin code

---

## Appendix: 2026 context for this lecture

If you learned Flutter before 2024, here's what changed:

| Topic | Old (pre-2024) | Current (2026) |
|---|---|---|
| Rendering engine | Skia | **Impeller** (iOS: Skia removed in 3.29, Android: 100% coverage via Vulkan/GLES) |
| Design language | Material 2 default | **Material 3** default since Flutter 3.16 |
| Material/Cupertino | Part of framework | Being extracted to `material_ui` / `cupertino_ui` packages (frozen in 3.44) |
| iOS deps | CocoaPods | **Swift Package Manager** default since 3.44 |
| Web renderer | HTML + CanvasKit | **CanvasKit only** (HTML removed in 3.29) |
| Dart version | 2.x | **3.x** with records, patterns, sealed classes, switch expressions |
| Android | Embedding v1 (Java) | **Embedding v2** (Kotlin); edge-to-edge default since 3.27 |
| Android Gradle | Imperative `apply` script | **Declarative `plugins {}` block** (Kotlin-based) |
| iOS lifecycle | AppDelegate | **UIScene lifecycle** default (required by Apple) |
