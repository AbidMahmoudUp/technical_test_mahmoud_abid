# Velia – Flutter technical exam

Implementation of the Senbiosys Figma design: the Welcome screen and the
three sections (Most powerful tips, Register, Ring onboarding), with all app
state managed through `provider`.

## Requirements

- Flutter **3.38.8** (stable), Dart **3.10.7**
- iOS simulator / Android emulator (designed on an iPhone 16 frame, 393×852)

## Setup

```bash
git clone https://github.com/AbidMahmoudUp/technical_test_mahmoud_abid.git
cd technical_test_mahmoud_abid
flutter pub get
flutter run
```

Run the analyzer and the widget tests (they walk through every flow):

```bash
flutter analyze
flutter test
```

## Flows

- **Welcome → Log in** → Most powerful tips → *Tobacco use* → question → back
  to the tips with the answer on the chip.
- **Welcome → Create account** → email → password → date of birth → height →
  ring setup → ring guide → tips.

## Project structure

```
lib/
  main.dart, app.dart          # MultiProvider + MaterialApp routes
  core/                        # assets, route names, colours, type scale, theme
  shared/widgets/              # AppButton, AppTopBar, GradientBackground,
                               # GlassCard (Figma inset shadows), ScaleCarousel
  features/
    welcome/
    tips/      models, providers (TipsProvider, LifestyleProvider), screens, widgets
    register/  providers (RegisterProvider), screens, widgets
    ring/      models, providers (RingOnboardingProvider), screens, widgets
```

Each feature exposes its own route map (`tipsRoutes`, `registerRoutes`,
`ringRoutes`) that `app.dart` spreads into `MaterialApp.routes`.

## State management

Every piece of app state lives in a `ChangeNotifier` provided at the root:
the current tip, the tobacco answer (draft until confirmed), all register
fields with their validation and password strength, and the ring guide and
photo carousel positions. Widgets read with `context.watch` / `select` and
write through provider methods. Only UI plumbing (text and page controllers,
focus nodes) lives in widget state.

## Notes

- **Fonts:** Suisse Intl is bundled from the **trial** files, which lack digits
  and some punctuation. Inter is declared as a fallback for those glyphs.
  Cormorant Garamond and Inter are open-source (OFL).
- **Placeholders:** the two side tip cards reuse the hiker photo, and the
  first tip's title is a placeholder.
- **Figma effects:** background blurs are not reproduced; on these flat
  backgrounds they make no visible difference. Inset shadows and gradient
  hairline borders are painted to match Figma.
- **Icons:** Material icons stand in for the thin-stroke Figma icons.
