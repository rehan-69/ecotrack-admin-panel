class ComplaintDetailModel {
  final int id;
  final String complaintId;
  final int? userId;
  final String userName;
  final List<String> image;
  final String title;
  final String description;
  final String wasteType;
  final String location;
  final String status;
  final String createdAt;
  final double? latitude;
  final double? longitude;
  final String? ward;

  ComplaintDetailModel({
    required this.id,
    required this.complaintId,
    this.userId,
    required this.userName,
    required this.image,
    required this.title,
    required this.description,
    required this.wasteType,
    required this.location,
    required this.status,
    required this.createdAt,
    this.latitude,
    this.longitude,
    this.ward,
  });

  factory ComplaintDetailModel.fromJson(Map<String, dynamic> json) {
    return ComplaintDetailModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      complaintId: json['complaint_id']?.toString() ?? '',
      userId: int.tryParse(json['user_id']?.toString() ?? ''),
      userName: json['user_name']?.toString() ?? 'Unknown',
      image: json['image'] is List
          ? List<String>.from(
              (json['image'] as List).map(
                (item) => item.toString(),
              ),
            )
          : [],
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      wasteType: json['waste_type']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      createdAt: json['created_at']?.toString() ?? '',
      latitude: double.tryParse(json['latitude']?.toString() ?? ''),
      longitude: double.tryParse(json['longitude']?.toString() ?? ''),
      ward: json['ward']?.toString(),
    );
  }
}