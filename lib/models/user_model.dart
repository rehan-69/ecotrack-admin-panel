class UserModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String joinedDate;
  final String status;
  final int complaintCount;
  final String provider;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.joinedDate,
    required this.status,
    required this.complaintCount,
    required this.provider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,

      name: json['name']?.toString() ?? 'Unknown',

      email: json['email']?.toString() ?? '',

      mobile: json['mobile']?.toString() ?? '',

      joinedDate: json['joined_date']?.toString() ?? '',

      status: json['is_verified'] == true ? 'Active' : 'Inactive',

      complaintCount:
          int.tryParse(json['complaint_count']?.toString() ?? '0') ?? 0,

      provider: json['provider']?.toString() == 'local'
          ? 'Email'
          : json['provider']?.toString() == 'google'
          ? 'Google'
          : json['provider']?.toString() ?? '',
    );
  }
}
