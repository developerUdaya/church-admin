class TestimonyModel {
  int id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  bool? deleteStatus;
  String title;
  String description;
  bool verifiedStatus;
  DateTime datetime;
  int user;

  TestimonyModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deleteStatus,
    required this.title,
    required this.description,
    required this.verifiedStatus,
    required this.datetime,
    required this.user,
  });

  factory TestimonyModel.fromJson(Map<String, dynamic> json) {
    return TestimonyModel(
      id: json['id'] ?? 0, // Default to 0 if null
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      createdBy: json['created_by'] ?? "Unknown", // Default to "Unknown"
      updatedBy: json['updated_by'] ?? "Unknown",
      deletedBy: json['deleted_by'] ?? "Unknown",
      deleteStatus: json['delete_status'] ?? false, // Default to false
      title: json['title'] ?? "No title available", // Handle null title
      description: json['description'] ??
          "No description available", // Handle null description
      verifiedStatus: json['verified_status'] ?? false, // Default to false
      datetime: json['datetime'] != null
          ? DateTime.parse(json['datetime'])
          : DateTime.now(), // Default to current date
      user: json['user'], // Keep as-is if it's an integer
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'delete_status': deleteStatus,
      'title': title,
      'description': description,
      'verified_status': verifiedStatus,
      'datetime': datetime.toIso8601String(),
      'user': user,
    };
  }
}
