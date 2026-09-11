import 'package:ecotrack_admin_panel/service/admin_api_service.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  // =========================
  // Navigation
  // =========================

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // =========================
  // Login
  // =========================

  bool isLoading = false;
  String? errorMessage;

  Future<bool> login({required String email, required String password}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await AdminApiService.loginAdmin(email: email, password: password);

      isLoading = false;
      notifyListeners();

      return true;
    } catch (error) {
      isLoading = false;
      errorMessage = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();

      return false;
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await AdminApiService.logout();

    selectedIndex = 0;
    errorMessage = null;

    notifyListeners();
  }

  // =========================
  // Dashboard
  // =========================

  bool dashboardLoading = false;
  String? dashboardError;

  int totalComplaints = 0;
  int pendingComplaints = 0;
  int inProgressComplaints = 0;
  int completedComplaints = 0;
  bool dashboardLoaded = false;

  List<Map<String, dynamic>> recentComplaints = [];

  Future<void> loadDashboard() async {
    dashboardLoading = true;
    dashboardError = null;

    notifyListeners();

    try {
      final data = await AdminApiService.getDashboard();

      final statistics = data['statistics'];

      totalComplaints = statistics['totalComplaints'] ?? 0;

      pendingComplaints = statistics['pending'] ?? 0;

      inProgressComplaints = statistics['inProgress'] ?? 0;

      completedComplaints = statistics['completed'] ?? 0;

      recentComplaints = List<Map<String, dynamic>>.from(
        data['recentComplaints'] ?? [],
      );
      dashboardLoaded = true;
      dashboardLoading = false;

      notifyListeners();
    } catch (error) {
      dashboardLoading = false;

      dashboardError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  // =========================
  // Complaints
  // =========================

  bool complaintsLoading = false;
  bool complaintsLoaded = false;
  String? complaintsError;

  List<Map<String, dynamic>> complaints = [];

  String complaintSearch = '';
  String? selectedStatus;
  String? selectedWasteType;
  String? selectedWard;

  Future<void> loadComplaints() async {
    complaintsLoading = true;
    complaintsError = null;

    notifyListeners();

    try {
      final data = await AdminApiService.getComplaints(
        search: complaintSearch,
        status: selectedStatus,
        wasteType: selectedWasteType,
        ward: selectedWard,
      );

      complaints = List<Map<String, dynamic>>.from(data['complaints'] ?? []);
      
      complaintsLoaded = true;
      complaintsLoading = false;

      notifyListeners();
    } catch (error) {
      complaintsLoading = false;

      complaintsError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  void setComplaintSearch(String value) {
    complaintSearch = value;
  }

  void setComplaintStatus(String? value) {
    selectedStatus = value;
  }

  void setComplaintWasteType(String? value) {
    selectedWasteType = value;
  }

  void setComplaintWard(String? value) {
    selectedWard = value;
  }
}
