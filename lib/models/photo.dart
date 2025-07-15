class Photo {
  final String id;
  final String url;
  final String thumbnailUrl;
  final bool isVideo;
  final DateTime dateAdded;
  final Map<String, dynamic>? metadata;

  Photo({
    required this.id,
    required this.url,
    this.thumbnailUrl = '',
    this.isVideo = false,
    required this.dateAdded,
    this.metadata,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      isVideo: json['isVideo'] ?? false,
      dateAdded: json['dateAdded'] != null ? DateTime.parse(json['dateAdded']) : DateTime.now(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'isVideo': isVideo,
      'dateAdded': dateAdded.toIso8601String(),
      'metadata': metadata,
    };
  }
}