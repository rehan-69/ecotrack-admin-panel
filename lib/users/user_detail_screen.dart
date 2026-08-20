import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final String name;
  final String email;
  final String mobile;
  final String joinedDate;
  final String totalComplaints;
  final String status;

  const UserDetailScreen({
    super.key,
    this.name = 'Rahul Sharma',
    this.email = 'rahul.sharma@gmail.com',
    this.mobile = '+919822041576',
    this.joinedDate = '12 Mar 2026',
    this.totalComplaints = '12 complaints',
    this.status = 'Active',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),
      body: Row(
        children: [
          _sideBar(),

          Expanded(
            child: Column(
              children: [
                _header(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _backButton(context),

                        const SizedBox(
                          height: 18,
                        ),

                        Text(
                          'User Details',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        _userCard(),

                        const SizedBox(
                          height: 34,
                        ),

                        const Text(
                          'Recent Complaints',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        _complaintsTable(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SIDEBAR
  Widget _sideBar() {
    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 66,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.eco_outlined,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                const Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EcoTrack',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Admin Panel',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
          ),

          const SizedBox(
            height: 18,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'MANAGEMENT',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          _menuItem(
            Icons.dashboard_outlined,
            'Dashboard',
            false,
          ),

          _menuItem(
            Icons.description_outlined,
            'Complaints',
            false,
          ),

          _menuItem(
            Icons.people_outline,
            'Users',
            true,
          ),

          _menuItem(
            Icons.delete_outline,
            'Waste Types',
            false,
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.grey.shade600,
                ),

                const SizedBox(
                  width: 12,
                ),

                Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    IconData icon,
    String title,
    bool selected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primaryColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: selected
                ? Colors.white
                : Colors.grey.shade600,
          ),

          const SizedBox(
            width: 14,
          ),

          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: selected
                  ? Colors.white
                  : Colors.grey.shade700,
              fontWeight: selected
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // HEADER
  Widget _header() {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Nashik Municipal Corporation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          const Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'admin@ecotrack.gov.in',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(
            width: 14,
          ),

          CircleAvatar(
            radius: 18,
            backgroundColor:
                Color(0xFFE8F5E9),
            child: Text(
              'AD',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BACK BUTTON
  Widget _backButton(
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(0xFF64748B),
          ),

          const SizedBox(
            width: 8,
          ),

          const Text(
            'Back',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // USER CARD
  Widget _userCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor:
                    AppColors.primaryColor,
                child: const Text(
                  'RS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rahul Sharma',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    height: 4,
                  ),

                  Text(
                    'Citizen · USR-01',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Account Status',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),

                  _statusBadge(),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          Row(
            children: [
              Expanded(
                child: _infoBox(
                  Icons.email_outlined,
                  'Email',
                  email,
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              Expanded(
                child: _infoBox(
                  Icons.phone_outlined,
                  'Mobile',
                  mobile,
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              Expanded(
                child: _infoBox(
                  Icons.calendar_today_outlined,
                  'Joined Date',
                  joinedDate,
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              Expanded(
                child: _infoBox(
                  Icons.description_outlined,
                  'Total Complaints',
                  totalComplaints,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      height: 75,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.grey.shade600,
              ),

              const SizedBox(
                width: 7,
              ),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFD9F5DF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF16833A),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // RECENT COMPLAINTS
  Widget _complaintsTable() {
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _tableRow(
            isHeader: true,
            complaintId: 'COMPLAINT ID',
            title: 'TITLE',
            wasteType: 'WASTE TYPE',
            date: 'DATE',
            status: 'STATUS',
            action: 'ACTION',
          ),

          _tableRow(
            complaintId: 'ECO-1042',
            title: 'Household Waste',
            wasteType: 'Household Waste',
            date: '12 Mar 2026',
            status: 'In Progress',
            action: 'View',
          ),
        ],
      ),
    );
  }

  Widget _tableRow({
    bool isHeader = false,
    required String complaintId,
    required String title,
    required String wasteType,
    required String date,
    required String status,
    required String action,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: isHeader
            ? const Color(0xFFF7F9F8)
            : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 15,
            child: _tableText(
              complaintId,
              isHeader,
            ),
          ),

          Expanded(
            flex: 18,
            child: _tableText(
              title,
              isHeader,
            ),
          ),

          Expanded(
            flex: 20,
            child: _tableText(
              wasteType,
              isHeader,
            ),
          ),

          Expanded(
            flex: 15,
            child: _tableText(
              date,
              isHeader,
            ),
          ),

          Expanded(
            flex: 15,
            child: isHeader
                ? _tableText(
                    status,
                    true,
                  )
                : Align(
                    alignment:
                        Alignment.centerLeft,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration:
                          BoxDecoration(
                        color: const Color(
                          0xFFE3F2FD,
                        ),
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
          ),

          Expanded(
            flex: 10,
            child: Text(
              action,
              style: TextStyle(
                fontSize: 13,
                color: isHeader
                    ? const Color(
                        0xFF64748B,
                      )
                    : AppColors.primaryColor,
                fontWeight: isHeader
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableText(
    String text,
    bool isHeader,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isHeader ? 12 : 14,
        color: isHeader
            ? const Color(0xFF64748B)
            : const Color(0xFF07152B),
        fontWeight: isHeader
            ? FontWeight.w500
            : FontWeight.w400,
      ),
    );
  }
}