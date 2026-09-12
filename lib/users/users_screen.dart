import 'package:flutter/material.dart';

import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/models/user_model.dart';
import 'package:ecotrack_admin_panel/users/user_detail_screen.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, child) {
        // Load users when screen opens
        if (!provider.usersLoaded &&
            !provider.usersLoading) {
          Future.microtask(
            () => provider.loadUsers(),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(
            context.width * 0.018,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Users',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: context.height * 0.008,
              ),

              Text(
                'Manage registered EcoTrack citizens.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(
                height: context.height * 0.025,
              ),

              _searchBox(
                context,
                provider,
              ),

              SizedBox(
                height: context.height * 0.025,
              ),

              _usersTable(
                context,
                provider,
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // Search Box
  // =========================

  Widget _searchBox(
    BuildContext context,
    AdminProvider provider,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        context.width * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth < 450
                ? constraints.maxWidth
                : 450,
            height: 48,
            child: TextField(
              style: const TextStyle(
                fontSize: 14,
              ),
              onChanged: (value) {
                provider.setUserSearch(value);
                provider.loadUsers();
              },
              decoration: InputDecoration(
                hintText: 'Search user',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================
  // Users Table
  // =========================

  Widget _usersTable(
    BuildContext context,
    AdminProvider provider,
  ) {
    const double tableWidth = 1100;

    // Loading
    if (provider.usersLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 60,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Error
    if (provider.usersError != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 60,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Center(
          child: Text(
            provider.usersError!,
            style: TextStyle(
              color: Colors.red.shade600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final List<UserModel> users =
        provider.users;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: tableWidth,
          child: Column(
            children: [
              _tableHeader(
                context,
                tableWidth,
              ),

              if (users.isEmpty)
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'No users found',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

              ...users.map(
                (UserModel user) {
                  return _userRow(
                    context,
                    tableWidth,
                    user,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // Table Header
  // =========================

  Widget _tableHeader(
    BuildContext context,
    double tableWidth,
  ) {
    return Container(
      height: 40,
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          _headerCell(
            context,
            'NAME',
            tableWidth * 0.14,
          ),

          _headerCell(
            context,
            'EMAIL',
            tableWidth * 0.22,
          ),

          _headerCell(
            context,
            'MOBILE',
            tableWidth * 0.15,
          ),

          _headerCell(
            context,
            'TOTAL COMPLAINTS',
            tableWidth * 0.15,
          ),

          _headerCell(
            context,
            'JOINED DATE',
            tableWidth * 0.12,
          ),

          _headerCell(
            context,
            'STATUS',
            tableWidth * 0.10,
          ),

          _headerCell(
            context,
            'ACTION',
            tableWidth * 0.08,
          ),
        ],
      ),
    );
  }

  Widget _headerCell(
    BuildContext context,
    String text,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =========================
  // User Row
  // =========================

  Widget _userRow(
    BuildContext context,
    double tableWidth,
    UserModel user,
  ) {
    final bool isActive =
        user.status.toLowerCase() ==
            'active';

    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          // Name
          _dataCell(
            context,
            user.name,
            tableWidth * 0.14,
            bold: true,
          ),

          // Email
          _dataCell(
            context,
            user.email,
            tableWidth * 0.22,
          ),

          // Mobile
          _dataCell(
            context,
            user.mobile.isEmpty
                ? '-'
                : user.mobile,
            tableWidth * 0.15,
          ),

          // Total Complaints
          _dataCell(
            context,
            '${user.complaintCount} complaints',
            tableWidth * 0.15,
          ),

          // Joined Date
          _dataCell(
            context,
            _formatDate(user.joinedDate),
            tableWidth * 0.12,
          ),

          // Status
          SizedBox(
            width: tableWidth * 0.10,
            child: Align(
              alignment:
                  Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(
                          0xFFDDF5E2,
                        )
                      : const Color(
                          0xFFF1F3F3,
                        ),
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  user.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive
                        ? Colors.green.shade700
                        : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),

          // Action
          SizedBox(
            width: tableWidth * 0.08,
            child: Align(
              alignment:
                  Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserDetailScreen(),
                    ),
                  );
                },
                style:
                    OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                child: Text(
                  'View',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Format Joined Date
  // =========================

  String _formatDate(String value) {
    if (value.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(value);

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${date.day.toString().padLeft(2, '0')} '
          '${months[date.month - 1]} '
          '${date.year}';
    } catch (error) {
      return value;
    }
  }

  // =========================
  // Data Cell
  // =========================

  Widget _dataCell(
    BuildContext context,
    String text,
    double width, {
    bool bold = false,
  }) {
    return SizedBox(
      width: width,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: bold
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}