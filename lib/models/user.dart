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