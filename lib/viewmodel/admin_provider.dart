import 'package:ecotrack_admin_panel/service/admin_api_service.dart';
import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier {
  int selectedIndex = 0;

  bool isLoading = false;
  String? errorMessage;

  // =========================
  // Navigation
  // =========================

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // =========================
  // Admin Login
  // =========================

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

  // =========================
  // Clear Error
  // =========================

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  // =========================
  // Logout
  // =========================

  Future<void> logout() async {
    await AdminApiService.logout();

    selectedIndex = 0;
    errorMessage = null;

    notifyListeners();
  }
}
