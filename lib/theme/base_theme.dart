import 'package:flutter/material.dart';

class LumiFrameDarkTheme {
  // Light mode text colors
  static const Color lightPrimaryText = Color(0xFF0C0C0F); // #0C0C0F
  static const Color lightSecondaryText = Color(0xFF18181A); // #18181A
  static const TextStyle lightHeadline = TextStyle(
    color: lightPrimaryText,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const TextStyle lightBody = TextStyle(
    color: lightPrimaryText,
    fontSize: 16,
  );
  static const TextStyle lightCaption = TextStyle(
    color: lightSecondaryText,
    fontSize: 12,
  );
  // Primary color palette
  static const Color primary = Color(0xFF4C4C4E);
  static const Color secondary = Color(0xFF38383A);
  static const Color surface = Color(0xFF29292B);
  static const Color background = Color(0xFF18181A);
  static const Color accent = Color(0xFF0C0C0F);
  static const Color white = Color(0xFFFFFFFF);

  // Universal nav selection color for glassmorphism containers
  static const Color navSelectionBase = Colors.black;
  static const double navSelectionOpacity = 0.18; // Tweak for glassmorphism compatibility
  static Color get navSelectionColor => navSelectionBase.withOpacity(navSelectionOpacity);

  // Glassmorphism settings
  static const double glassBlur = 20.0;
  static const double glassOpacity = 0.3;
  static const Color glassTint = Color(0xFF29292B);

  // Shadows
  static const List<BoxShadow> glassShadows = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  // Text styles
  static const TextStyle headline = TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const TextStyle body = TextStyle(
    color: white,
    fontSize: 16,
  );
  static const Color secondaryText = Color(0xFFCCCCCC); // light gray for secondary text
  static const TextStyle caption = TextStyle(
    color: secondaryText,
    fontSize: 12,
  );

  // Button styles
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
    shadowColor: Colors.black45,
  );

  // Icon theme
  static const IconThemeData iconTheme = IconThemeData(
    color: white,
    size: 24,
  );

  // Divider
  static const DividerThemeData dividerTheme = DividerThemeData(
    color: secondary,
    thickness: 1,
  );

  // Card theme
  static const CardThemeData cardTheme = CardThemeData(
    color: surface,
    elevation: 8,
    shadowColor: Colors.black38,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  );

  // Input decoration
  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: secondary),
    ),
    hintStyle: TextStyle(color: secondary),
    labelStyle: TextStyle(color: white),
  );

  // Snackbar theme
  static const SnackBarThemeData snackBarTheme = SnackBarThemeData(
    backgroundColor: surface,
    contentTextStyle: TextStyle(color: white),
    actionTextColor: accent,
  );

  // Switch theme
  static const SwitchThemeData switchTheme = SwitchThemeData(
    thumbColor: MaterialStatePropertyAll<Color>(primary),
    trackColor: MaterialStatePropertyAll<Color>(secondary),
  );
  
  // Light mode switch theme
  static const Color lightSwitchThumb = white; // white thumb for light mode
  static Color get lightSwitchTrack => navSelectionColor; // opaque black track, matches nav selection
  static SwitchThemeData get lightSwitchTheme => SwitchThemeData(
    thumbColor: MaterialStatePropertyAll<Color>(lightSwitchThumb),
    trackColor: MaterialStatePropertyAll<Color>(lightSwitchTrack),
  );
  
  // Returns correct SwitchThemeData based on brightness
  static SwitchThemeData getSwitchTheme(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? switchTheme : lightSwitchTheme;
  }

  // Slider theme
  static SliderThemeData sliderTheme(BuildContext context) => SliderTheme.of(context).copyWith(
    activeTrackColor: accent,
    inactiveTrackColor: secondary,
    thumbColor: primary,
    overlayColor: accent.withOpacity(0.2),
  );

  // Progress indicator theme
  static const ProgressIndicatorThemeData progressIndicatorTheme = ProgressIndicatorThemeData(
    color: accent,
    linearTrackColor: secondary,
    circularTrackColor: secondary,
  );
}
