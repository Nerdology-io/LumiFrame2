class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final Map<String, dynamic> preferences;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName = '',
    this.photoUrl,
    this.preferences = const {},
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'] ?? '',
      photoUrl: json['photoUrl'],
      preferences: json['preferences'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'preferences': preferences,
    };
  }
}