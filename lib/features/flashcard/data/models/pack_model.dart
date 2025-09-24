class PackModel {
  final int? id;
  final String title;
  final String? description;
  final String? category;
  final String? createdAt;

  PackModel({
    this.id,
    required this.title,
    this.description,
    this.category,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'createdAt': createdAt,
    };
  }

  factory PackModel.fromMap(Map<String, dynamic> map) {
    return PackModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      createdAt: map['createdAt'],
    );
  }
}