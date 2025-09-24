class PackEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;

  PackEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
  });
}