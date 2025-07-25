# LumiFrame Theme System

This directory contains the comprehensive theming system for LumiFrame, designed to support multiple glassmorphism themes with consistent styling across all UI components.

## Directory Structure

### 📁 `core/`
Core theming infrastructure and base classes
- `theme_config.dart` - Main theme configuration class
- `theme_constants.dart` - Shared constants (blur values, opacity levels, etc.)
- `glassmorphism_base.dart` - Base glassmorphism styling utilities
- `color_palette.dart` - Color system and palette management
- `typography.dart` - Text styles and typography system
- `animations.dart` - Theme-aware animation configurations

### 📁 `components/`
Theme definitions for specific UI components

#### 📁 `buttons/`
- `button_themes.dart` - All button variants (auth, action, dialog, floating, etc.)
- `toggle_themes.dart` - Toggle switches and radio buttons
- `chip_themes.dart` - Chip and tag styling

#### 📁 `inputs/`
- `input_themes.dart` - Text fields, search bars, text areas
- `dropdown_themes.dart` - Dropdown menus and selectors
- `slider_themes.dart` - Sliders and range inputs
- `picker_themes.dart` - Date/time pickers and spinners

#### 📁 `navigation/`
- `nav_themes.dart` - Navigation bars, pills, and drawer
- `tab_themes.dart` - Tab bars and segmented controls
- `breadcrumb_themes.dart` - Breadcrumbs and progress indicators

#### 📁 `containers/`
- `container_themes.dart` - Basic containers and wrappers
- `card_themes.dart` - Card variants and layouts
- `panel_themes.dart` - Side panels and collapsible sections

#### 📁 `dialogs/`
- `dialog_themes.dart` - Modal dialogs and popups
- `snackbar_themes.dart` - Snackbars and toast messages
- `tooltip_themes.dart` - Tooltips and help overlays

#### 📁 `cards/`
- `media_card_themes.dart` - Photo/video display cards
- `info_card_themes.dart` - Information and status cards
- `selection_card_themes.dart` - Selectable and interactive cards

#### 📁 `media/`
- `image_themes.dart` - Image containers and galleries
- `video_themes.dart` - Video players and thumbnails
- `avatar_themes.dart` - Profile pictures and user avatars

#### 📁 `overlays/`
- `overlay_themes.dart` - Loading overlays and backdrops
- `sheet_themes.dart` - Bottom sheets and modal sheets
- `popup_themes.dart` - Context menus and action sheets

### 📁 `effects/`
Glassmorphism effects and visual enhancements
- `blur_effects.dart` - Backdrop blur configurations
- `gradient_effects.dart` - Gradient definitions and utilities
- `shadow_effects.dart` - Box shadow and glow effects
- `border_effects.dart` - Border styles and animations
- `particle_effects.dart` - Particle and motion effects

### 📁 `themes/`
Complete theme definitions
- `aurora_theme.dart` - Aurora theme (blues/greens/purples)
- `sunset_theme.dart` - Sunset theme (oranges/reds/yellows)
- `ocean_theme.dart` - Ocean theme (blues/teals/aquas)
- `cosmic_theme.dart` - Cosmic theme (purples/magentas/blues)
- `forest_theme.dart` - Forest theme (greens/browns/golds)
- `ember_theme.dart` - Ember theme (reds/oranges/blacks)
- `frost_theme.dart` - Frost theme (whites/blues/silvers)
- `midnight_theme.dart` - Midnight theme (dark blues/blacks/purples)
- `rose_theme.dart` - Rose theme (pinks/corals/whites)
- `golden_theme.dart` - Golden theme (golds/yellows/oranges)

### 📁 `presets/`
Theme preset configurations and utilities
- `theme_presets.dart` - All available theme presets
- `theme_builder.dart` - Dynamic theme building utilities
- `theme_validator.dart` - Theme validation and testing

## Usage

```dart
// Get current theme
final theme = Get.find<ThemeController>();

// Apply glassmorphism button styling
GlassmorphismButton(
  style: theme.currentTheme.buttons.primary,
  onPressed: () {},
  child: Text('Button'),
)

// Use theme-aware container
GlassmorphismContainer(
  style: theme.currentTheme.containers.card,
  child: YourContent(),
)
```

## Theme Structure

Each theme provides:
- **Color Palette**: Primary, secondary, accent, surface, and text colors
- **Effects**: Blur intensities, opacity levels, gradient configurations
- **Typography**: Font weights, sizes, and color applications
- **Animations**: Duration, curves, and transition styles
- **Component Styles**: Specific styling for each UI component type

## Adding New Themes

1. Create a new theme file in `themes/`
2. Extend the base theme configuration
3. Define color palette and effects
4. Configure component-specific styles
5. Add to theme presets collection

## Component Integration

Each themeable component should:
1. Accept a theme style parameter
2. Apply glassmorphism effects consistently
3. Support both light and dark variants
4. Maintain accessibility standards
5. Include hover/focus/active states
