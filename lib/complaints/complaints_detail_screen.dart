import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:ecotrack_admin_panel/views/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final String complaintId;
  final String image;
  final String title;
  final String citizen;
  final String wasteType;
  final String location;
  final String date;
  final String status;

  const ComplaintDetailScreen({
    super.key,
    required this.complaintId,
    required this.image,
    required this.title,
    required this.citizen,
    required this.wasteType,
    required this.location,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        final bool isMobile =
            MediaQuery.of(context).size.width < 900;

        if (isMobile) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7FAF8),

            drawer: Drawer(
              width: 280,
              backgroundColor: Colors.white,
              child: SideBar(
                selectedIndex: 1,
                onItemSelected: (index) {
                  value.changeIndex(index);
                  Navigator.pop(context);
                },
              ),
            ),

            appBar: _mobileHeader(context),

            body: _content(context),
          );
        }

        return Scaffold(
          body: Row(
            children: [
              SideBar(
                selectedIndex: 1,
                onItemSelected: (index) {
                  value.changeIndex(index);
                },
              ),

              Expanded(
                child: Column(
                  children: [
                    _header(context),

                    Expanded(
                      child: _content(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // DESKTOP HEADER
  // ============================================================

  Widget _header(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
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

          Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              const Text(
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
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),

          const SizedBox(
            width: 12,
          ),

          const CircleAvatar(
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

  // ============================================================
  // MOBILE HEADER
  // ============================================================

  PreferredSizeWidget _mobileHeader(
    BuildContext context,
  ) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF1B1B27),
      elevation: 0,
      toolbarHeight: 64,

      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
          );
        },
      ),

      titleSpacing: 0,

      title: const Text(
        'Admin Panel',
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // MAIN CONTENT
  // ============================================================

  Widget _content(BuildContext context) {
    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile =
        screenWidth < 900;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF7FAF8),

      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          isMobile ? 16 : 26,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ====================================================
            // BACK
            // ====================================================

            InkWell(
              onTap: () {
                Navigator.pop(context);
              },

              child: Row(
                mainAxisSize:
                    MainAxisSize.min,

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
            ),

            const SizedBox(
              height: 20,
            ),

            // ====================================================
            // TITLE
            // ====================================================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center,

              children: [
                Expanded(
                  child: Text(
                    'Complaint Details',
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF07152B),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                _statusBadge(
                  context,
                  status,
                  const Color(0xFFE3F2FD),
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            // ====================================================
            // DESKTOP
            // ====================================================

            if (!isMobile)
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _complaintImage(
                          context,
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        _complaintInformation(
                          context,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    width: 24,
                  ),

                  SizedBox(
                    width: 328,
                    child: Column(
                      children: [
                        _currentStatusCard(
                          context,
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        _statusTimeline(
                          context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            // ====================================================
            // MOBILE / TABLET
            // ====================================================

            if (isMobile)
              Column(
                children: [
                  _complaintImage(
                    context,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  _currentStatusCard(
                    context,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  _statusTimeline(
                    context,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  _complaintInformation(
                    context,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COMPLAINT IMAGE
  // ============================================================

  Widget _complaintImage(
    BuildContext context,
  ) {
    final double screenWidth =
        MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius:
          BorderRadius.circular(15),

      child: SizedBox(
        width: double.infinity,

        height: screenWidth < 600
            ? 250
            : 385,

        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ============================================================
  // CURRENT STATUS
  // ============================================================

  Widget _currentStatusCard(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Current Status',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          _statusBadge(
            context,
            status,
            const Color(0xFFE3F2FD),
            Colors.blue,
          ),

          const SizedBox(
            height: 25,
          ),

          const Text(
            'Update Complaint Status',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Container(
            width: double.infinity,
            height: 38,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(9),

              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),

            child: Row(
              children: [
                Expanded(
                  child: Text(
                    status,
                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          SizedBox(
            width: double.infinity,
            height: 37,

            child: ElevatedButton(
              onPressed: () {},

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primaryColor,
                foregroundColor:
                    Colors.white,
                elevation: 0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(9),
                ),
              ),

              child: const Text(
                'Update Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMPLAINT INFORMATION
  // ============================================================

  Widget _complaintInformation(
    BuildContext context,
  ) {
    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile =
        screenWidth < 600;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Complaint Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          if (!isMobile)
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Expanded(
                  child:
                      _leftInformation(
                    context,
                  ),
                ),

                const SizedBox(
                  width: 35,
                ),

                Expanded(
                  child:
                      _rightInformation(
                    context,
                  ),
                ),
              ],
            ),

          if (isMobile)
            Column(
              children: [
                _leftInformation(
                  context,
                ),

                const SizedBox(
                  height: 15,
                ),

                _rightInformation(
                  context,
                ),
              ],
            ),

          const SizedBox(
            height: 15,
          ),

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color:
                  const Color(0xFFF7F9F8),
              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        Color(0xFF64748B),
                  ),
                ),

                const SizedBox(
                  height: 7,
                ),

                const Text(
                  'Garbage bin near the bus stop has been overflowing for three days.',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Color(0xFF07152B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LEFT INFORMATION
  // ============================================================

  Widget _leftInformation(
    BuildContext context,
  ) {
    return Column(
      children: [
        _informationItem(
          context,
          Icons.local_offer_outlined,
          'Complaint ID',
          complaintId,
        ),

        const SizedBox(
          height: 15,
        ),

        _informationItem(
          context,
          Icons.person_outline,
          'Citizen',
          citizen,
        ),

        const SizedBox(
          height: 15,
        ),

        _informationItem(
          context,
          Icons.location_on_outlined,
          'Location',
          location,
        ),

        const SizedBox(
          height: 15,
        ),

        _informationItem(
          context,
          Icons.location_on_outlined,
          'GPS Location',
          '19.9975° N, 73.7898° E',
        ),
      ],
    );
  }

  // ============================================================
  // RIGHT INFORMATION
  // ============================================================

  Widget _rightInformation(
    BuildContext context,
  ) {
    return Column(
      children: [
        _informationItem(
          context,
          Icons.local_offer_outlined,
          'Complaint Title',
          title,
        ),

        const SizedBox(
          height: 15,
        ),

        _informationItem(
          context,
          Icons.local_offer_outlined,
          'Waste Type',
          wasteType,
        ),

        const SizedBox(
          height: 15,
        ),

        _informationItem(
          context,
          Icons.calendar_today_outlined,
          'Submitted Date',
          date,
        ),
      ],
    );
  }

  // ============================================================
  // INFORMATION ITEM
  // ============================================================

  Widget _informationItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Container(
          width: 34,
          height: 34,

          decoration: BoxDecoration(
            color:
                const Color(0xFFEAF7EE),
            borderRadius:
                BorderRadius.circular(10),
          ),

          child: Icon(
            icon,
            size: 18,
            color:
                AppColors.primaryColor,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color:
                      Color(0xFF64748B),
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                value,
                maxLines: 3,
                overflow:
                    TextOverflow.ellipsis,

                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w500,
                  color:
                      Color(0xFF07152B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STATUS TIMELINE
  // ============================================================

  Widget _statusTimeline(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Text(
            'Status Timeline',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          _timelineItem(
            context,
            'Submitted',
            true,
            false,
            '1',
          ),

          _timelineItem(
            context,
            'Pending',
            true,
            false,
            '2',
          ),

          _timelineItem(
            context,
            'In Progress',
            true,
            true,
            '3',
          ),

          _timelineItem(
            context,
            'Completed',
            false,
            false,
            '4',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TIMELINE ITEM
  // ============================================================

  Widget _timelineItem(
    BuildContext context,
    String title,
    bool completed,
    bool current,
    String number,
  ) {
    return SizedBox(
      height: 64,

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,

                decoration: BoxDecoration(
                  color: current
                      ? AppColors
                          .primaryColor
                      : completed
                          ? const Color(
                              0xFFF4FBF6,
                            )
                          : const Color(
                              0xFFF3F5F6,
                            ),

                  shape:
                      BoxShape.circle,

                  border: Border.all(
                    color: current
                        ? AppColors
                            .primaryColor
                        : completed
                            ? AppColors
                                .primaryColor
                            : const Color(
                                0xFFDCE3E7,
                              ),
                  ),
                ),

                child: Center(
                  child: completed
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: current
                              ? Colors.white
                              : AppColors
                                  .primaryColor,
                        )
                      : Text(
                          number,
                          style:
                              const TextStyle(
                            fontSize: 12,
                            color: Color(
                              0xFF64748B,
                            ),
                          ),
                        ),
                ),
              ),

              if (title != 'Completed')
                Expanded(
                  child: Container(
                    width: 1,
                    color:
                        AppColors.primaryColor,
                  ),
                ),
            ],
          ),

          const SizedBox(
            width: 12,
          ),

          Padding(
            padding:
                const EdgeInsets.only(
              top: 5,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: current
                        ? FontWeight.w500
                        : FontWeight.w400,
                    color: current
                        ? AppColors
                            .primaryColor
                        : const Color(
                            0xFF334155,
                          ),
                  ),
                ),

                if (current)
                  const Text(
                    'Current status',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          Color(0xFF94A3B8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _statusBadge(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color textColor,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Text(
        text,
        maxLines: 1,
        overflow:
            TextOverflow.ellipsis,

        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight:
              FontWeight.w500,
        ),
      ),
    );
  }
}