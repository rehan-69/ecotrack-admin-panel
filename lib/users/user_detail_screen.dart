import 'package:flutter/material.dart';
import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/complaints/complaints_detail_screen.dart';

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
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    if (isMobile) {
      return Scaffold(
        backgroundColor: const Color(0xFFF7FAF8),

        drawer: Drawer(
          width: 280,
          backgroundColor: Colors.white,
          child: _sideBar(context),
        ),

        appBar: _mobileHeader(context),

        body: _mainContent(context),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),

      body: Row(
        children: [
          _sideBar(context),

          Expanded(
            child: Column(
              children: [
                _header(context),

                Expanded(child: _mainContent(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MAIN CONTENT

  Widget _mainContent(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _backButton(context),

          SizedBox(height: MediaQuery.of(context).size.height * 0.018),

          const Text(
            'User Details',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.025),

          _userCard(context),

          SizedBox(height: MediaQuery.of(context).size.height * 0.035),

          const Text(
            'Recent Complaints',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.016),

          _complaintsTable(context),
        ],
      ),
    );
  }

  // MOBILE HEADER

  PreferredSizeWidget _mobileHeader(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 64,

      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.black54, size: 28),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),

      title: Row(
        children: [
          const Text(
            'Nashik Municipal Corporation',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),
          SizedBox(width: context.width * 0.005),

          const CircleAvatar(
            radius: 15,
            backgroundColor: Color(0xFF2E8B45),
            child: Text(
              'AD',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      titleSpacing: 0,
    );
  }

  // SIDEBAR

  Widget _sideBar(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    double sidebarWidth;

    if (isMobile) {
      sidebarWidth = 280;
    } else if (MediaQuery.of(context).size.width < 1200) {
      sidebarWidth = 180;
    } else {
      sidebarWidth = 250;
    }

    return Container(
      width: sidebarWidth,
      color: Colors.white,

      child: Column(
        children: [
          // LOGO
          Container(
            height: 66,

            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 20),

            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,

                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(Icons.eco_outlined, color: Colors.white),
                ),

                const SizedBox(width: 12),

                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.start,

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
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          const SizedBox(height: 18),

          // MANAGEMENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Align(
              alignment: Alignment.centerLeft,

              child: const Text(
                'MANAGEMENT',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          _menuItem(context, Icons.dashboard_outlined, 'Dashboard', false),

          _menuItem(context, Icons.description_outlined, 'Complaints', false),

          _menuItem(context, Icons.people_outline, 'Users', true),

          _menuItem(context, Icons.delete_outline, 'Waste Types', false),

          const Spacer(),

          // LOGOUT
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),

            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.grey.shade600),

                const SizedBox(width: 12),

                const Text(
                  'Logout',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MENU ITEM

  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title,
    bool selected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),

      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

      decoration: BoxDecoration(
        color: selected ? AppColors.primaryColor : Colors.transparent,

        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            size: 20,

            color: selected ? Colors.white : Colors.grey.shade600,
          ),

          const SizedBox(width: 14),

          Text(
            title,
            style: TextStyle(
              fontSize: 15,

              color: selected ? Colors.white : Colors.grey.shade700,

              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // DESKTOP HEADER

  Widget _header(BuildContext context) {
    return Container(
      height: 66,

      padding: const EdgeInsets.symmetric(horizontal: 24),

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),

      child: Row(
        children: [
          const Text(
            'Nashik Municipal Corporation',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const Spacer(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.end,

            children: const [
              Text(
                'Admin',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              Text(
                'admin@ecotrack.gov.in',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 18,

            backgroundColor: Color(0xFFE8F5E9),

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

  Widget _backButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: const [
          Icon(Icons.arrow_back, size: 20, color: Color(0xFF64748B)),

          SizedBox(width: 8),

          Text(
            'Back',
            style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  // USER CARD

  Widget _userCard(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;

    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(isMobile ? 16 : 20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        border: Border.all(color: Colors.grey.shade200),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        children: [
          // USER HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CircleAvatar(
                radius: isMobile ? 23 : 28,

                backgroundColor: AppColors.primaryColor,

                child: const Text(
                  'RS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(width: isMobile ? 10 : 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Citizen · USR-01',
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  const Text(
                    'Account Status',
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),

                  const SizedBox(height: 7),

                  _statusBadge(context),
                ],
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.025),

          // MOBILE INFO BOXES
          if (width < 700)
            Column(
              children: [
                _responsiveInfoBox(
                  context,
                  Icons.email_outlined,
                  'Email',
                  email,
                ),

                const SizedBox(height: 12),

                _responsiveInfoBox(
                  context,
                  Icons.phone_outlined,
                  'Mobile',
                  mobile,
                ),

                const SizedBox(height: 12),

                _responsiveInfoBox(
                  context,
                  Icons.calendar_today_outlined,
                  'Joined Date',
                  joinedDate,
                ),

                const SizedBox(height: 12),

                _responsiveInfoBox(
                  context,
                  Icons.description_outlined,
                  'Total Complaints',
                  totalComplaints,
                ),
              ],
            )
          else
            // DESKTOP INFO BOXES
            Row(
              children: [
                Expanded(
                  child: _infoBox(
                    context,
                    Icons.email_outlined,
                    'Email',
                    email,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _infoBox(
                    context,
                    Icons.phone_outlined,
                    'Mobile',
                    mobile,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _infoBox(
                    context,
                    Icons.calendar_today_outlined,
                    'Joined Date',
                    joinedDate,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _infoBox(
                    context,
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

  // RESPONSIVE INFO BOX

  Widget _responsiveInfoBox(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return SizedBox(
      width: double.infinity,

      child: _infoBox(context, icon, title, value),
    );
  }

  // INFO BOX

  Widget _infoBox(
    BuildContext context,
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

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade600),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // STATUS BADGE

  Widget _statusBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

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

  Widget _complaintsTable(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        border: Border.all(color: Colors.grey.shade200),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        child: SizedBox(
          width: MediaQuery.of(context).size.width < 700
              ? 750
              : MediaQuery.of(context).size.width,

          child: Column(
            children: [
              _tableRow(
                context,
                isHeader: true,
                complaintId: 'COMPLAINT ID',
                title: 'TITLE',
                wasteType: 'WASTE TYPE',
                date: 'DATE',
                status: 'STATUS',
                action: 'ACTION',
              ),

              _tableRow(
                context,
                complaintId: 'ECO-1042',
                title: 'Household Waste',
                wasteType: 'Household Waste',
                date: '12 Mar 2026',
                status: 'In Progress',
                action: 'View',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TABLE ROW

  Widget _tableRow(
    BuildContext context, {
    bool isHeader = false,
    required String complaintId,
    required String title,
    required String wasteType,
    required String date,
    required String status,
    required String action,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFFF7F9F8) : Colors.white,

        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),

      child: Row(
        children: [
          Expanded(flex: 15, child: _tableText(context, complaintId, isHeader)),

          Expanded(flex: 18, child: _tableText(context, title, isHeader)),

          Expanded(flex: 20, child: _tableText(context, wasteType, isHeader)),

          Expanded(flex: 15, child: _tableText(context, date, isHeader)),

          Expanded(
            flex: 15,
            child: isHeader
                ? _tableText(context, status, true)
                : Align(
                    alignment: Alignment.centerLeft,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),

                        borderRadius: BorderRadius.circular(20),
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintDetailScreen(id: 28),
                  ),
                );
              },
              child: Text(
                action,
                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: 13,
                  color: isHeader
                      ? const Color(0xFF64748B)
                      : AppColors.primaryColor,

                  fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TABLE TEXT

  Widget _tableText(BuildContext context, String text, bool isHeader) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,

      style: TextStyle(
        fontSize: isHeader ? 12 : 14,

        color: isHeader ? const Color(0xFF64748B) : const Color(0xFF07152B),

        fontWeight: isHeader ? FontWeight.w500 : FontWeight.w400,
      ),
    );
  }
}
