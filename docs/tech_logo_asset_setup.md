# Tech Logo Asset Setup Guide

`Jay2xCoder` uses local SVG assets for lightweight offline icons.

## Current icon paths
- `assets/tech/html5.svg`
- `assets/tech/css3.svg`
- `assets/tech/javascript.svg`
- `assets/tech/git.svg`
- `assets/tech/api.svg`
- `assets/tech/json.svg`
- `assets/tech/flutter.svg`
- `assets/tech/firebase.svg`

## Recommended sources
- Devicon: https://devicon.dev/
- Simple Icons: https://simpleicons.org/

## Replace placeholder icons
1. Download SVG icon files for each technology.
2. Optimize files (recommended) using SVGO.
3. Replace the matching files in `assets/tech/` with the same filenames.
4. Keep SVG dimensions simple (`viewBox` only, no embedded scripts).
5. Run `flutter pub get` if pubspec changed, then `flutter run`.

## Keep assets lightweight
- Prefer plain SVG paths.
- Avoid gradients or heavy filters in icon files.
- Keep each file under ~10KB if possible.

## Usage in code
Icons are rendered with `flutter_svg` through:
- `lib/presentation/shared/widgets/tech_icon.dart`
