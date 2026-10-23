# Shamedan - El-Shamedan Snack Brand App

## Project Overview
Arabic RTL Flutter mobile app showcasing El-Shamedan snack brand characters and products.
Each character (Omda, Beskawy, Cookies, Kitkito) has a dedicated item screen with hero, story, timeline, interactive, and footer sections.

## Architecture
```
lib/
├── main.dart
├── core/
│   ├── utils/        # AppColor, AppFonts (Google Fonts: Lalezar, Cairo, Lemonada, ArefRuqaa)
│   └── widgets/      # CustomAppBar, CharacterCard
├── Features/
│   ├── home/
│   │   ├── presentation/  # HomeScreen
│   │   └── widgets/       # FirstSection..FifthSection (each in own file)
│   └── item/
│       ├── data/          # ItemModel, ItemRepository (loads from assets/mock_backend/items.json)
│       └── presentation/
│           ├── itemscreen.dart  # Coordinator screen - composes section widgets
│           └── widgets/         # Each section in its own file:
│               ├── hero_section.dart
│               ├── decorative_letters_section.dart
│               ├── character_story_section.dart
│               ├── timeline_section.dart
│               ├── interactive_section.dart
│               └── item_footer_section.dart
assets/
├── images/         # Character PNGs, icons, product images
└── mock_backend/   # items.json (4 items + 4 characters)
```

## Key Data
- **Items**: id 1=Omda (#A42B20), 2=Beskawy (#4F8C82), 3=Cookies (#2C1B14), 4=Kitkito
- **Colors per item**: themeColor, backgroundColor, waveColor, cardColor, footerColor (all hex in JSON)
- **Font styles**: `AppFonts.titleLalezar`, `AppFonts.regularCairo`, `AppFonts.titleLemonada`
- **Direction**: Always RTL via `Directionality(textDirection: TextDirection.rtl, ...)`
- **RTL positioning**: Use `PositionedDirectional` with `start`/`end` (not `left`/`right`)

## Tech Stack
- Flutter (Dart SDK ^3.12.2)
- google_fonts: ^8.1.0
- No state management library (StatefulWidget + setState)
- Assets loaded via rootBundle from `assets/mock_backend/items.json`
