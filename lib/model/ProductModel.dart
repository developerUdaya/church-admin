class ProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int category;
  final bool status;
  final List<String> videoUrls;
  final List<String> imageUrls;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final bool? deleteStatus;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.status,
    required this.videoUrls,
    required this.imageUrls,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteStatus,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      status: json['status'],
      videoUrls: List<String>.from(json['video_urls']),
      imageUrls: List<String>.from(json['image_urls']),
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      updatedBy: json['updated_by'],
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      deletedBy: json['deleted_by'],
      deleteStatus: json['delete_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'status': status,
      'video_urls': videoUrls,
      'image_urls': imageUrls,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'deleted_by': deletedBy,
      'delete_status': deleteStatus,
    };
  }
}
