class SpeechModel {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;
  final bool? deleteStatus;
  final DateTime datetime;
  final String speech;
  final int? user;

  SpeechModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.deleteStatus,
    required this.datetime,
    required this.speech,
    this.user,
  });

  factory SpeechModel.fromJson(Map<String, dynamic> json) {
    return SpeechModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      deleteStatus: json['delete_status'],
      datetime: DateTime.parse(json['datetime']),
      speech: json['speech'],
      user: json['user'],
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
      'datetime': datetime.toIso8601String(),
      'speech': speech,
      'user': user,
    };
  }
}
