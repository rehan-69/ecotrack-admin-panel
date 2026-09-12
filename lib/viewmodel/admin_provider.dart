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

  // =========================
  // Complaint Wards
  // =========================

  bool complaintWardsLoading = false;

  List<String> complaintWards = [];

  Future<void> loadComplaintWards() async {
    if (complaintWardsLoading) return;

    complaintWardsLoading = true;

    notifyListeners();

    try {
      final wards = await AdminApiService.getComplaintWards();

      complaintWards = ['All Wards', ...wards];

      complaintWardsLoading = false;

      notifyListeners();
    } catch (error) {
      complaintWardsLoading = false;

      notifyListeners();
    }
  }

  // =========================
  // Complaint Waste Types
  // =========================

  bool wasteTypesLoading = false;

  List<String> complaintWasteTypes = [];
  Future<void> loadComplaintWasteTypes() async {
    if (wasteTypesLoading) return;

    wasteTypesLoading = true;
    notifyListeners();

    try {
      final data = await AdminApiService.getWasteTypes();

      complaintWasteTypes = [
        'All Waste Types',
        ...List<String>.from(
          (data['wasteTypes'] ?? []).map((item) => item['name'].toString()),
        ),
      ];

      wasteTypesLoading = false;
      notifyListeners();
    } catch (error) {
      wasteTypesLoading = false;
      notifyListeners();
    }
  }

  // =========================
  // Load Complaints
  // =========================

  Future<void> loadComplaints() async {
    complaintsLoading = true;
    complaintsError = null;

    if (complaintWards.isEmpty) {
      loadComplaintWards();
    }

    if (complaintWasteTypes.isEmpty) {
      loadComplaintWasteTypes();
    }

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

  // =========================
  // Complaint Search
  // =========================

  void setComplaintSearch(String value) {
    complaintSearch = value;
  }

  // =========================
  // Complaint Status
  // =========================

  void setComplaintStatus(String? value) {
    selectedStatus = value;

    complaintsLoaded = false;

    loadComplaints();
  }

  // =========================
  // Complaint Waste Type
  // =========================

  void setComplaintWasteType(String? value) {
    selectedWasteType = value;
  }

  // =========================
  // Complaint Ward
  // =========================

  void setComplaintWard(String? value) {
    selectedWard = value;
  }

    // =========================
  // Complaint Detail
  // =========================

  bool complaintDetailLoading = false;
  String? complaintDetailError;
  Map<String, dynamic>? complaintDetail;

  Future<void> loadComplaintDetail(int id) async {
    complaintDetailLoading = true;
    complaintDetailError = null;
    complaintDetail = null;
    notifyListeners();

    try {
      final data = await AdminApiService.getComplaintById(id);

      complaintDetail = Map<String, dynamic>.from(
        data['complaint'] ?? {},
      );

      complaintDetailLoading = false;
      notifyListeners();
    } catch (error) {
      complaintDetailLoading = false;
      complaintDetailError =
          error.toString().replaceFirst('Exception: ', '');
      notifyListeners();
    }
  }

  void clearComplaintDetail() {
    complaintDetail = null;
    complaintDetailError = null;
    complaintDetailLoading = false;
  }
}
