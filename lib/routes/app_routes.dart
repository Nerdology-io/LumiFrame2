import 'package:get/get.dart';
import '../screens/auth/email_address_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/phone_login_screen.dart';
import '../screens/dashboard/components/cast_screen.dart';
import '../screens/dashboard/components/dashboard_screen.dart';
import '../screens/dashboard/components/media_browsing_screen.dart';
import '../screens/dashboard/components/settings_screen.dart';
import '../screens/onboarding/onboarding_carousel.dart';
import '../screens/onboarding/onboarding_start.dart';
import '../screens/onboarding/time_adaptive_onboarding.dart';
import '../screens/onboarding/customize_experience_onboarding.dart';
import '../screens/onboarding/media_source_selection_onboarding.dart';
import '../screens/onboarding/personalization_onboarding.dart';
import '../screens/profile/edit_profile.dart';
import '../screens/profile/my_profile.dart';
import '../screens/settings/advanced_settings_screen.dart';
import '../screens/settings/appearance_settings_screen.dart';
import '../screens/settings/media_sources_screen.dart';
import '../screens/slideshow_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/auth/login', page: () => LoginScreen()),
    GetPage(name: '/auth/email_address', page: () => EmailAddressScreen()),
    GetPage(name: '/auth/phone-login', page: () => const PhoneLoginScreen()),
    GetPage(name: '/auth/otp', page: () => const OtpScreen()),
    GetPage(name: '/dashboard/cast', page: () => CastScreen()),
    GetPage(name: '/dashboard', page: () => DashboardScreen()),
    GetPage(name: '/dashboard/media_browsing', page: () => MediaBrowsingScreen()),
    GetPage(name: '/dashboard/settings', page: () => SettingsScreen()),
    GetPage(name: '/onboarding/carousel', page: () => OnboardingCarousel()),
    GetPage(name: '/onboarding/start', page: () => OnboardingStart()),
    GetPage(name: '/onboarding/welcome', page: () => const TimeAdaptiveOnboarding()),
    GetPage(name: '/onboarding/features', page: () => const CustomizeExperienceOnboarding()),
    GetPage(name: '/onboarding/media-sources', page: () => const MediaSourceSelectionOnboarding()),
    GetPage(name: '/onboarding/personalization', page: () => const PersonalizationOnboarding()),
    GetPage(name: '/profile/edit', page: () => EditProfile()),
    GetPage(name: '/profile/my', page: () => MyProfile()),
    GetPage(name: '/settings/advanced', page: () => AdvancedSettingsScreen()),
    GetPage(name: '/settings/appearance', page: () => AppearanceSettingsScreen()),
    GetPage(name: '/settings/media_sources', page: () => MediaSourcesScreen()),
    GetPage(name: '/slideshow', page: () => SlideshowScreen()),
  ];
}