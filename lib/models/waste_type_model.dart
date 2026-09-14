class WasteTypeModel {
  final int id;
  final String name;
  final String description;
  final int complaintCount;
  final String createdAt;

  WasteTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.complaintCount,
    required this.createdAt,
  });

  factory WasteTypeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return WasteTypeModel(
      id: int.tryParse(
            json['id']?.toString() ?? '0',
          ) ??
          0,

      name:
          json['name']?.toString() ?? '',

      description:
          json['description']?.toString() ?? '',

      complaintCount:
          int.tryParse(
                json['complaint_count']?.toString() ?? '0',
              ) ??
              0,

      createdAt:
          json['created_at']?.toString() ?? '',
    );
  }
}