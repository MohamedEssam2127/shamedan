# Code Style Rules

- This is an Arabic RTL app. All text widgets must use `textDirection: TextDirection.rtl` or be inside a `Directionality` widget.
- Use `PositionedDirectional` with `start`/`end` instead of `Positioned` with `left`/`right`.
- Each UI section must be in its own widget file under the feature's `widgets/` directory.
- The coordinator screen (e.g. `itemscreen.dart`) should only compose section widgets — no inline UI building.
- Use `AppFonts` static styles from `core/utils/Appfonts.dart` — never create ad-hoc TextStyles.
- Use `AppColor` constants from `core/utils/app_color.dart` for shared colors.
- Item-specific colors come from the JSON model (hex strings), parsed via `_parseColor`.
- Preserve all existing comments and docstrings.
- Always run `flutter analyze` on changed files before committing.
- Commit messages should be concise and descriptive. Never add co-author or contributor tags.
