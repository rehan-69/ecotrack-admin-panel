import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
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
          _sideBar(context),

          Expanded(
            child: Column(
              children: [
                _header(context),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(
                      context.width < 600 ? 16 : 24,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        _backButton(context),

                        SizedBox(
                          height: context.height * 0.018,
                        ),

                        Text(
                          'User Details',
                          style: TextStyle(
                            fontSize:
                                context.responsiveFont(26),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(
                          height: context.height * 0.025,
                        ),

                        _userCard(context),

                        SizedBox(
                          height: context.height * 0.035,
                        ),

                        Text(
                          'Recent Complaints',
                          style: TextStyle(
                            fontSize:
                                context.responsiveFont(17),
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(
                          height: context.height * 0.016,
                        ),

                        _complaintsTable(context),
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

  Widget _sideBar(BuildContext context) {
    double sidebarWidth;

    if (context.width < 600) {
      sidebarWidth = 90;
    } else if (context.width < 900) {
      sidebarWidth = 180;
    } else {
      sidebarWidth = 250;
    }

    return Container(
      width: sidebarWidth,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 66,
            padding: EdgeInsets.symmetric(
              horizontal:
                  context.width < 600 ? 10 : 20,
            ),
            child: context.width < 600
                ? Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            AppColors.primaryColor,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.eco_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color:
                              AppColors.primaryColor,
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

                      Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EcoTrack',
                            style: TextStyle(
                              fontSize:
                                  context.responsiveFont(
                                16,
                              ),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Admin Panel',
                            style: TextStyle(
                              fontSize:
                                  context.responsiveFont(
                                12,
                              ),
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

          SizedBox(
            height: context.height * 0.02,
          ),

          if (context.width >= 600)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MANAGEMENT',
                  style: TextStyle(
                    fontSize:
                        context.responsiveFont(11),
                    color:
                        const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          SizedBox(
            height: context.height * 0.012,
          ),

          _menuItem(
            context,
            Icons.dashboard_outlined,
            'Dashboard',
            false,
          ),

          _menuItem(
            context,
            Icons.description_outlined,
            'Complaints',
            false,
          ),

          _menuItem(
            context,
            Icons.people_outline,
            'Users',
            true,
          ),

          _menuItem(
            context,
            Icons.delete_outline,
            'Waste Types',
            false,
          ),

          const Spacer(),

          Container(
            padding: EdgeInsets.all(
              context.width < 600 ? 12 : 20,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: context.width < 600
                ? Center(
                    child: Icon(
                      Icons.logout,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  )
                : Row(
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
                          fontSize:
                              context.responsiveFont(15),
                          color:
                              Colors.grey.shade700,
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
    BuildContext context,
    IconData icon,
    String title,
    bool selected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.width < 600 ? 6 : 12,
        vertical: 3,
      ),
      padding: EdgeInsets.symmetric(
        horizontal:
            context.width < 600 ? 8 : 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primaryColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: context.width < 600
          ? Center(
              child: Icon(
                icon,
                size: 20,
                color: selected
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
            )
          : Row(
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
                    fontSize:
                        context.responsiveFont(15),
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

  Widget _header(BuildContext context) {
    return Container(
      height: 66,
      padding: EdgeInsets.symmetric(
        horizontal:
            context.width < 600 ? 12 : 24,
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
          Text(
            'Nashik Municipal Corporation',
            style: TextStyle(
              fontSize:
                  context.responsiveFont(16),
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  fontSize:
                      context.responsiveFont(15),
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'admin@ecotrack.gov.in',
                style: TextStyle(
                  fontSize:
                      context.responsiveFont(12),
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(
            width: context.width * 0.01,
          ),

          CircleAvatar(
            radius: context.width < 600
                ? 16
                : 18,
            backgroundColor:
                const Color(0xFFE8F5E9),
            child: Text(
              'AD',
              style: TextStyle(
                fontSize:
                    context.responsiveFont(12),
                fontWeight: FontWeight.bold,
                color:
                    const Color(0xFF2E7D32),
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
          Icon(
            Icons.arrow_back,
            size: context.responsiveFont(20),
            color: const Color(0xFF64748B),
          ),

          const SizedBox(
            width: 8,
          ),

          Text(
            'Back',
            style: TextStyle(
              fontSize:
                  context.responsiveFont(14),
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // USER CARD

  Widget _userCard(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        context.width < 600 ? 16 : 20,
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: context.width < 600
                    ? 23
                    : 28,
                backgroundColor:
                    AppColors.primaryColor,
                child: Text(
                  'RS',
                  style: TextStyle(
                    fontSize:
                        context.responsiveFont(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                width: context.width < 600
                    ? 10
                    : 16,
              ),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize:
                          context.responsiveFont(20),
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    'Citizen · USR-01',
                    style: TextStyle(
                      fontSize:
                          context.responsiveFont(14),
                      color:
                          const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    'Account Status',
                    style: TextStyle(
                      fontSize:
                          context.responsiveFont(13),
                      color:
                          const Color(0xFF64748B),
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),

                  _statusBadge(context),
                ],
              ),
            ],
          ),

          SizedBox(
            height: context.height * 0.025,
          ),

          if (context.width < 700)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _responsiveInfoBox(
                  context,
                  Icons.email_outlined,
                  'Email',
                  email,
                ),

                _responsiveInfoBox(
                  context,
                  Icons.phone_outlined,
                  'Mobile',
                  mobile,
                ),

                _responsiveInfoBox(
                  context,
                  Icons.calendar_today_outlined,
                  'Joined Date',
                  joinedDate,
                ),

                _responsiveInfoBox(
                  context,
                  Icons.description_outlined,
                  'Total Complaints',
                  totalComplaints,
                ),
              ],
            )
          else
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

                const SizedBox(
                  width: 16,
                ),

                Expanded(
                  child: _infoBox(
                    context,
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
                    context,
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

  Widget _responsiveInfoBox(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    double boxWidth;

    if (context.width < 450) {
      boxWidth = double.infinity;
    } else {
      boxWidth =
          (context.width - 110) / 2;
    }

    return SizedBox(
      width: boxWidth,
      child: _infoBox(
        context,
        icon,
        title,
        value,
      ),
    );
  }

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
                size: context.responsiveFont(16),
                color: Colors.grey.shade600,
              ),

              const SizedBox(
                width: 7,
              ),

              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:
                        context.responsiveFont(12),
                    color:
                        const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize:
                  context.responsiveFont(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            context.responsiveFont(12),
        vertical:
            context.responsiveFont(5),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFD9F5DF),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize:
              context.responsiveFont(12),
          color: const Color(0xFF16833A),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // RECENT COMPLAINTS

  Widget _complaintsTable(
    BuildContext context,
  ) {
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: context.width < 700
              ? 750
              : context.width,
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
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical:
            context.responsiveFont(14),
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
              context,
              complaintId,
              isHeader,
            ),
          ),

          Expanded(
            flex: 18,
            child: _tableText(
              context,
              title,
              isHeader,
            ),
          ),

          Expanded(
            flex: 20,
            child: _tableText(
              context,
              wasteType,
              isHeader,
            ),
          ),

          Expanded(
            flex: 15,
            child: _tableText(
              context,
              date,
              isHeader,
            ),
          ),

          Expanded(
            flex: 15,
            child: isHeader
                ? _tableText(
                    context,
                    status,
                    true,
                  )
                : Align(
                    alignment:
                        Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(
                        horizontal:
                            context.responsiveFont(
                          10,
                        ),
                        vertical:
                            context.responsiveFont(
                          5,
                        ),
                      ),
                      decoration: BoxDecoration(
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
                        style: TextStyle(
                          fontSize:
                              context.responsiveFont(
                            12,
                          ),
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
                fontSize:
                    context.responsiveFont(13),
                color: isHeader
                    ? const Color(0xFF64748B)
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
    BuildContext context,
    String text,
    bool isHeader,
  ) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: context.responsiveFont(
          isHeader ? 12 : 14,
        ),
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