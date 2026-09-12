class ComplaintModel {
  final int id;
  final String complaintId;
  final List<String> image;
  final String title;
  final String userName;
  final String wasteType;
  final String location;
  final String? ward;
  final String createdAt;
  final String status;

  ComplaintModel({
    required this.id,
    required this.complaintId,
    required this.image,
    required this.title,
    required this.userName,
    required this.wasteType,
    required this.location,
    this.ward,
    required this.createdAt,
    required this.status,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      complaintId: json['complaint_id']?.toString() ?? '',
      image: json['image'] is List
          ? List<String>.from(
              (json['image'] as List).map(
                (item) => item.toString(),
              ),
            )
          : [],
      title: json['title']?.toString() ?? '',
      userName: json['user_name']?.toString() ?? 'Unknown',
      wasteType: json['waste_type']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      ward: json['ward']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
    );
  }
}