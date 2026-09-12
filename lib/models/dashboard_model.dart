import 'complaint_model.dart';

class DashboardModel {
  final int totalComplaints;
  final int pending;
  final int inProgress;
  final int completed;
  final List<ComplaintModel> recentComplaints;

  DashboardModel({
    required this.totalComplaints,
    required this.pending,
    required this.inProgress,
    required this.completed,
    required this.recentComplaints,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final statistics = json['statistics'] ?? {};

    return DashboardModel(
      totalComplaints: statistics['totalComplaints'] ?? 0,
      pending: statistics['pending'] ?? 0,
      inProgress: statistics['inProgress'] ?? 0,
      completed: statistics['completed'] ?? 0,
      recentComplaints: (json['recentComplaints'] as List? ?? [])
          .map(
            (item) => ComplaintModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
    );
  }
}