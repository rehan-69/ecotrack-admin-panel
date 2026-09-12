class UserDetailModel {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String joinedDate;
  final String status;
  final bool isVerified;
  final String provider;
  final String location;
  final List<UserComplaintModel> complaints;

  UserDetailModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.joinedDate,
    required this.status,
    required this.isVerified,
    required this.provider,
    required this.location,
    required this.complaints,
  });

  factory UserDetailModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserDetailModel(
      id: int.tryParse(
            json['id']?.toString() ?? '0',
          ) ??
          0,

      name: json['name']?.toString() ?? 'Unknown',

      email: json['email']?.toString() ?? '',

      mobile: json['mobile']?.toString() ?? '',

      joinedDate:
          json['joined_date']?.toString() ?? '',

      status:
          json['status']?.toString() ?? 'Inactive',

      isVerified:
          json['is_verified'] == true,

      provider:
          json['provider']?.toString() ?? '',

      location:
          json['location']?.toString() ?? '',

      complaints:
          (json['complaints'] as List? ?? [])
              .map(
                (item) =>
                    UserComplaintModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList(),
    );
  }
}


// =========================
// User Complaint Model
// =========================

class UserComplaintModel {
  final int id;
  final String complaintId;
  final String title;
  final String wasteType;
  final String location;
  final String status;
  final String createdAt;

  UserComplaintModel({
    required this.id,
    required this.complaintId,
    required this.title,
    required this.wasteType,
    required this.location,
    required this.status,
    required this.createdAt,
  });

  factory UserComplaintModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserComplaintModel(
      id: int.tryParse(
            json['id']?.toString() ?? '0',
          ) ??
          0,

      complaintId:
          json['complaint_id']?.toString() ?? '',

      title:
          json['title']?.toString() ?? '',

      wasteType:
          json['waste_type']?.toString() ?? '',

      location:
          json['location']?.toString() ?? '',

      status:
          json['status']?.toString() ?? 'Pending',

      createdAt:
          json['created_at']?.toString() ?? '',
    );
  }
}