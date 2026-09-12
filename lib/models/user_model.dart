class UserModel {
  final int id;
  final String name;
  final String email;
  final int complaintCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.complaintCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(
            json['id']?.toString() ?? '0',
          ) ??
          0,
      name: json['name']?.toString() ?? 'Unknown',
      email: json['email']?.toString() ?? '',
      complaintCount: int.tryParse(
            json['complaint_count']?.toString() ?? '0',
          ) ??
          0,
    );
  }
}