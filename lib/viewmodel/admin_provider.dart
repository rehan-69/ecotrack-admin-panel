import 'package:flutter/material.dart';

import 'package:ecotrack_admin_panel/service/admin_api_service.dart';

import 'package:ecotrack_admin_panel/models/complaint_model.dart';
import 'package:ecotrack_admin_panel/models/complaint_detail_model.dart';
import 'package:ecotrack_admin_panel/models/dashboard_model.dart';
import 'package:ecotrack_admin_panel/models/user_model.dart';
import 'package:ecotrack_admin_panel/models/user_detail_model.dart';
import 'package:ecotrack_admin_panel/models/waste_type_model.dart';

class AdminProvider extends ChangeNotifier {
  // =========================
  // Navigation
  // =========================

  int selectedIndex = 0;

  String municipalityRemark = '';
  
  void setMunicipalityRemark(String value) {
    municipalityRemark = value;
    notifyListeners();
  }

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

  DashboardModel? dashboard;

  List<ComplaintModel> recentComplaints = [];

  Future<void> loadDashboard() async {
    dashboardLoading = true;
    dashboardError = null;

    notifyListeners();

    try {
      final data = await AdminApiService.getDashboard();

      dashboard = DashboardModel.fromJson(data);

      totalComplaints = dashboard!.totalComplaints;

      pendingComplaints = dashboard!.pending;

      inProgressComplaints = dashboard!.inProgress;

      completedComplaints = dashboard!.completed;

      recentComplaints = dashboard!.recentComplaints;

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

      complaints = (data['complaints'] as List? ?? [])
          .map(
            (item) => ComplaintModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();

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

  ComplaintDetailModel? complaintDetail;

  String? selectedComplaintStatus;

  // =========================
  // Load Complaint Detail
  // =========================

  Future<void> loadComplaintDetail(int id) async {
    complaintDetailLoading = true;
    complaintDetailError = null;
    complaintDetail = null;
    selectedComplaintStatus = null;

    notifyListeners();

    try {
      final data = await AdminApiService.getComplaintById(id);

      final complaintData = Map<String, dynamic>.from(
        data['complaint'] ?? data,
      );

      complaintDetail = ComplaintDetailModel.fromJson(complaintData);

      selectedComplaintStatus = complaintDetail!.status;

      complaintDetailLoading = false;

      notifyListeners();
    } catch (error) {
      complaintDetailLoading = false;

      complaintDetailError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  // =========================
  // Selected Detail Status
  // =========================

  void setSelectedDetailStatus(String? value) {
    selectedComplaintStatus = value;

    notifyListeners();
  }

  // =========================
  // Update Complaint Status
  // =========================

  Future<void> updateComplaintStatus({
    required int id,
    required String status,
    String? remark,
  }) async {
    try {
      await AdminApiService.updateComplaintStatus(
        id: id,
        status: status,
        remark: remark,
      );

      selectedComplaintStatus = status;

      if (complaintDetail != null) {
        complaintDetail = ComplaintDetailModel(
          id: complaintDetail!.id,
          complaintId: complaintDetail!.complaintId,
          image: complaintDetail!.image,
          title: complaintDetail!.title,
          userName: complaintDetail!.userName,
          wasteType: complaintDetail!.wasteType,
          location: complaintDetail!.location,
          ward: complaintDetail!.ward,
          createdAt: complaintDetail!.createdAt,
          status: status,
          description: complaintDetail!.description,
          latitude: complaintDetail!.latitude,
          longitude: complaintDetail!.longitude,
          municipalityRemark: remark ?? complaintDetail!.municipalityRemark,
        );
      }

      notifyListeners();

      await loadComplaints();
      await loadDashboard();
    } catch (error) {
      complaintDetailError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  // =========================
  // Clear Complaint Detail
  // =========================

  void clearComplaintDetail() {
    complaintDetail = null;
    complaintDetailError = null;
    complaintDetailLoading = false;
    selectedComplaintStatus = null;

    notifyListeners();
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
      final data = await AdminApiService.getUsers(search: userSearch);

      users = (data['users'] as List? ?? [])
          .map((item) => UserModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();

      usersLoaded = true;
      usersLoading = false;

      notifyListeners();
    } catch (error) {
      usersLoading = false;

      usersError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  // =========================
  // User Search
  // =========================

  void setUserSearch(String value) {
    userSearch = value;
  }

  // =========================
  // User Detail
  // =========================

  bool userDetailLoading = false;

  String? userDetailError;

  UserDetailModel? userDetail;

  // =========================
  // Load User Detail
  // =========================

  Future<void> loadUserDetail(int id) async {
    userDetailLoading = true;
    userDetailError = null;
    userDetail = null;

    notifyListeners();

    try {
      final data = await AdminApiService.getUserById(id);

      final userData = Map<String, dynamic>.from(data['user'] ?? {});

      userData['complaints'] = data['complaints'] ?? [];

      userDetail = UserDetailModel.fromJson(userData);

      userDetailLoading = false;

      notifyListeners();
    } catch (error) {
      userDetailLoading = false;

      userDetailError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  // =========================
  // Clear User Detail
  // =========================

  void clearUserDetail() {
    userDetail = null;
    userDetailError = null;
    userDetailLoading = false;

    notifyListeners();
  }

  // =========================
  // Waste Types
  // =========================

  bool adminWasteTypesLoading = false;

  bool adminWasteTypesLoaded = false;

  String? adminWasteTypesError;

  List<WasteTypeModel> wasteTypes = [];

  // =========================
  // Load Waste Types
  // =========================

  Future<void> loadWasteTypes() async {
    adminWasteTypesLoading = true;
    adminWasteTypesError = null;

    notifyListeners();

    try {
      final data = await AdminApiService.getWasteTypes();

      wasteTypes = (data['wasteTypes'] as List? ?? [])
          .map(
            (item) => WasteTypeModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();

      adminWasteTypesLoaded = true;
      adminWasteTypesLoading = false;

      notifyListeners();
    } catch (error) {
      adminWasteTypesLoading = false;

      adminWasteTypesError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();
    }
  }

  // =========================
  // Clear Waste Types Error
  // =========================

  void clearWasteTypesError() {
    adminWasteTypesError = null;

    notifyListeners();
  }

  Future<bool> addWasteType({
    required String name,
    required String description,
  }) async {
    try {
      await AdminApiService.createWasteType(
        name: name,
        description: description,
      );

      await loadWasteTypes();

      return true;
    } catch (error) {
      adminWasteTypesError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();

      return false;
    }
  }

  Future<bool> deleteWasteType(int id) async {
    try {
      await AdminApiService.deleteWasteType(id);

      await loadWasteTypes();

      return true;
    } catch (error) {
      adminWasteTypesError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateWasteType({
    required int id,
    required String name,
    required String description,
  }) async {
    try {
      await AdminApiService.updateWasteType(
        id: id,
        name: name,
        description: description,
      );

      await loadWasteTypes();

      return true;
    } catch (error) {
      adminWasteTypesError = error.toString().replaceFirst('Exception: ', '');

      notifyListeners();

      return false;
    }
  }
}
