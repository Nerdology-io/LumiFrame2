class Album {
  final String id;
  final String name;
  final String source; // 'local', 'google_photos', 'flickr'
  final String? thumbnailUrl;
  final int photoCount;
  final DateTime dateCreated;
  final DateTime dateModified;
  final Map<String, dynamic>? metadata;

  Album({
    required this.id,
    required this.name,
    required this.source,
    this.thumbnailUrl,
    required this.photoCount,
    required this.dateCreated,
    required this.dateModified,
    this.metadata,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as String,
      name: json['name'] as String,
      source: json['source'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      photoCount: json['photoCount'] as int? ?? 0,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      dateModified: DateTime.parse(json['dateModified'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'source': source,
      'thumbnailUrl': thumbnailUrl,
      'photoCount': photoCount,
      'dateCreated': dateCreated.toIso8601String(),
      'dateModified': dateModified.toIso8601String(),
      'metadata': metadata,
    };
  }

  Album copyWith({
    String? id,
    String? name,
    String? source,
    String? thumbnailUrl,
    int? photoCount,
    DateTime? dateCreated,
    DateTime? dateModified,
    Map<String, dynamic>? metadata,
  }) {
    return Album(
      id: id ?? this.id,
      name: name ?? this.name,
      source: source ?? this.source,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      photoCount: photoCount ?? this.photoCount,
      dateCreated: dateCreated ?? this.dateCreated,
      dateModified: dateModified ?? this.dateModified,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Album &&
        other.id == id &&
        other.source == source;
  }

  @override
  int get hashCode => id.hashCode ^ source.hashCode;

  @override
  String toString() {
    return 'Album(id: $id, name: $name, source: $source, photoCount: $photoCount)';
  }
}
