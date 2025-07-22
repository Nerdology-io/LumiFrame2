import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String uid;
  final String email;
  final String? displayName;
  final String? customDisplayName; // User-overridden name
  final String? phoneNumber;
  final String? photoURL;
  final String? provider; // 'google', 'apple', 'facebook', 'email', 'phone'
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final AppSettings settings;

  UserProfile({
    required this.uid,
    required this.email,
    this.displayName,
    this.customDisplayName,
    this.phoneNumber,
    this.photoURL,
    this.provider,
    this.createdAt,
    this.lastLogin,
    AppSettings? settings,
  }) : settings = settings ?? AppSettings();

  // The name to actually display (priority: custom > provider > fallback)
  String get effectiveDisplayName {
    if (customDisplayName != null && customDisplayName!.trim().isNotEmpty) {
      return customDisplayName!.trim();
    }
    if (displayName != null && displayName!.trim().isNotEmpty) {
      return displayName!.trim();
    }
    // Fallback to first part of email or "User"
    if (email.isNotEmpty) {
      final emailName = email.split('@').first;
      return emailName.isNotEmpty ? emailName : 'User';
    }
    return 'User';
  }

  // First name for casual addressing
  String get firstName {
    final name = effectiveDisplayName;
    return name.split(' ').first;
  }

  factory UserProfile.fromFirebaseUser(User firebaseUser, {AppSettings? settings}) {
    return UserProfile(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      phoneNumber: firebaseUser.phoneNumber,
      photoURL: firebaseUser.photoURL,
      provider: _getProvider(firebaseUser),
      createdAt: firebaseUser.metadata.creationTime,
      lastLogin: firebaseUser.metadata.lastSignInTime,
      settings: settings,
    );
  }

  static String? _getProvider(User user) {
    for (final provider in user.providerData) {
      switch (provider.providerId) {
        case 'google.com':
          return 'google';
        case 'apple.com':
          return 'apple';
        case 'facebook.com':
          return 'facebook';
        case 'phone':
          return 'phone';
        case 'password':
          return 'email';
      }
    }
    return null;
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'],
      customDisplayName: json['customDisplayName'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      provider: json['provider'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      lastLogin: json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      settings: json['settings'] != null ? AppSettings.fromJson(json['settings']) : AppSettings(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'customDisplayName': customDisplayName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'provider': provider,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'settings': settings.toJson(),
    };
  }

  UserProfile copyWith({
    String? displayName,
    String? customDisplayName,
    String? phoneNumber,
    String? photoURL,
    AppSettings? settings,
  }) {
    return UserProfile(
      uid: uid,
      email: email,
      displayName: displayName ?? this.displayName,
      customDisplayName: customDisplayName ?? this.customDisplayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      provider: provider,
      createdAt: createdAt,
      lastLogin: lastLogin,
      settings: settings ?? this.settings,
    );
  }
}

class AppSettings {
  final bool autoPlay;
  final int slideshowInterval;
  final String themeMode;
  final bool notificationsEnabled;

  AppSettings({
    this.autoPlay = true,
    this.slideshowInterval = 5,
    this.themeMode = 'system',
    this.notificationsEnabled = true,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      autoPlay: json['autoPlay'] ?? true,
      slideshowInterval: json['slideshowInterval'] ?? 5,
      themeMode: json['themeMode'] ?? 'system',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoPlay': autoPlay,
      'slideshowInterval': slideshowInterval,
      'themeMode': themeMode,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}