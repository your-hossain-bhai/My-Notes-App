class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String docId) {
    return Note(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'createdAt': createdAt,
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
