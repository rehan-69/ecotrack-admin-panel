import 'package:flutter/material.dart';

import 'package:ecotrack_admin_panel/service/admin_api_service.dart';

import 'package:ecotrack_admin_panel/models/complaint_model.dart';
import 'package:ecotrack_admin_panel/models/dashboard_model.dart';
import 'package:ecotrack_admin_panel/models/complaint_detail_model.dart';
import 'package:ecotrack_admin_panel/models/user_model.dart';

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

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await AdminApiService.loginAdmin(
        email: email,
        password: password,
      );

      isLoading = false;

      notifyListeners();

      return true;
    } catch (error) {
      isLoading = false;

      errorMessage =
          error.toString().replaceFirst(
                'Exception: ',
                '',
              );

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

  DashboardModel? dashboard;

  List<ComplaintModel> recentComplaints = [];

  Future<void> loadDashboard() async {
    dashboardLoading = true;
    dashboardError = null;

    notifyListeners();

    try {
      final data =
          await AdminApiService.getDashboard();

      dashboard =
          DashboardModel.fromJson(data);

      totalComplaints =
          dashboard!.totalComplaints;

      pendingComplaints =
          dashboard!.pending;

      inProgressComplaints =
          dashboard!.inProgress;

      completedComplaints =
          dashboard!.completed;

      recentComplaints =
          dashboard!.recentComplaints;

      dashboardLoaded = true;
      dashboardLoading = false;

      notifyListeners();
    } catch (error) {
      dashboardLoading = false;

      dashboardError =
          error.toString().replaceFirst(
                'Exception: ',
                '',
              );

      notifyListeners();
    }
  }

  // =========================
  // Complaints
  // =========================

  bool complaintsLoading = false;
  bool complaintsLoaded = false;
  String? complaintsError;

  List<ComplaintModel> complaints = [];

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
      final wards =
          await AdminApiService
              .getComplaintWards();

      complaintWards = [
        'All Wards',
        ...wards,
      ];

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

  Future<void>
      loadComplaintWasteTypes() async {
    if (wasteTypesLoading) return;

    wasteTypesLoading = true;

    notifyListeners();

    try {
      final data =
          await AdminApiService.getWasteTypes();

      complaintWasteTypes = [
        'All Waste Types',
        ...List<String>.from(
          (data['wasteTypes'] ?? [])
              .map(
                (item) =>
                    item['name'].toString(),
              ),
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
      final data =
          await AdminApiService.getComplaints(
        search: complaintSearch,
        status: selectedStatus,
        wasteType: selectedWasteType,
        ward: selectedWard,
      );

      complaints =
          (data['complaints'] as List? ?? [])
              .map(
                (item) =>
                    ComplaintModel.fromJson(
                  Map<String, dynamic>.from(
                    item,
                  ),
                ),
              )
              .toList();

      complaintsLoaded = true;
      complaintsLoading = false;

      notifyListeners();
    } catch (error) {
      complaintsLoading = false;

      complaintsError =
          error.toString().replaceFirst(
                'Exception: ',
                '',
              );

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

  String? selectedComplaintStatus;

  ComplaintDetailModel? complaintDetail;

  Future<void> loadComplaintDetail(
    int id,
  ) async {
    complaintDetailLoading = true;
    complaintDetailError = null;
    complaintDetail = null;

    notifyListeners();

    try {
      final data =
          await AdminApiService
              .getComplaintById(id);

      complaintDetail =
          ComplaintDetailModel.fromJson(
        Map<String, dynamic>.from(
          data['complaint'] ?? {},
        ),
      );

      complaintDetailLoading = false;

      notifyListeners();
    } catch (error) {
      complaintDetailLoading = false;

      complaintDetailError =
          error.toString().replaceFirst(
                'Exception: ',
                '',
              );

      notifyListeners();
    }
  }

  void clearComplaintDetail() {
    complaintDetail = null;
    complaintDetailError = null;
    complaintDetailLoading = false;
  }

  void setSelectedDetailStatus(
    String? value,
  ) {
    selectedComplaintStatus = value;

    notifyListeners();
  }

  Future<bool> updateComplaintStatus(
    int id,
  ) async {
    final newStatus =
        selectedComplaintStatus;

    if (newStatus == null) {
      return false;
    }

    try {
      await AdminApiService
          .updateComplaintStatus(
        id: id,
        status: newStatus,
      );

      if (complaintDetail != null) {
        complaintDetail =
            ComplaintDetailModel(
          id: complaintDetail!.id,
          complaintId:
              complaintDetail!.complaintId,
          userId:
              complaintDetail!.userId,
          userName:
              complaintDetail!.userName,
          image:
              complaintDetail!.image,
          title:
              complaintDetail!.title,
          description:
              complaintDetail!.description,
          wasteType:
              complaintDetail!.wasteType,
          location:
              complaintDetail!.location,
          status: newStatus,
          createdAt:
              complaintDetail!.createdAt,
          latitude:
              complaintDetail!.latitude,
          longitude:
              complaintDetail!.longitude,
          ward:
              complaintDetail!.ward,
        );
      }

      notifyListeners();

      return true;
    } catch (error) {
      complaintDetailError =
          error.toString().replaceFirst(
                'Exception: ',
                '',
              );

      notifyListeners();

      return false;
    }
  }

  // =========================
  // Users
  // =========================

  bool usersLoading = false;
  bool usersLoaded = false;
  String? usersError;

  List<UserModel> users = [];

  String userSearch = '';

  // =========================
  // Load Users
  // =========================

  Future<void> loadUsers() async {
    usersLoading = true;
    usersError = null;

    notifyListeners();

    try {
      final data =
          await AdminApiService.getUsers(
        search: userSearch,
      );

      users =
          (data['users'] as List? ?? [])
              .map(
                (item) =>
                    UserModel.fromJson(
                  Map<String, dynamic>.from(
                    item,
                  ),
                ),
              )
              .toList();

      usersLoaded = true;
      usersLoading = false;

      notifyListeners();
    } catch (error) {
      usersLoading = false;

      usersError =
          error.toString().replaceFirst(
                'Exception: ',
                '',
              );

      notifyListeners();
    }
  }

  // =========================
  // User Search
  // =========================

  void setUserSearch(String value) {
    userSearch = value;
  }
}