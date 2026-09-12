import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/views/widgets/side_bar.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final int id;
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
    required this.id,
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
        final bool isMobile = MediaQuery.of(context).size.width < 900;

        if (value.complaintDetail == null &&
            !value.complaintDetailLoading &&
            value.complaintDetailError == null) {
          Future.microtask(() {
            value.loadComplaintDetail(id);
          });
        }

        if (value.complaintDetailError != null) {
          return Scaffold(
            body: Center(
              child: Text(
                value.complaintDetailError!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

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

  // DESKTOP HEADER

  Widget _header(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
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
            icon: const Icon(
              Icons.menu,
              color: Colors.black54,
              size: 28,
            ),
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

          SizedBox(
            width: context.width * 0.005,
          ),

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

  // MAIN CONTENT

  Widget _content(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    final detailComplaint =
        context.read<AdminProvider>().complaintDetail;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF7FAF8),

      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          isMobile ? 16 : 26,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // BACK

            InkWell(
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

                  const SizedBox(width: 8),

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

            const SizedBox(height: 20),

            // TITLE

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Expanded(
                  child: Text(
                    'Complaint Details',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF07152B),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                _statusBadge(
                  context,
                  detailComplaint?.status ?? status,
                  const Color(0xFFE3F2FD),
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // DESKTOP

            if (!isMobile)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _complaintImage(context),

                        const SizedBox(height: 24),

                        _complaintInformation(context),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  SizedBox(
                    width: 328,
                    child: Column(
                      children: [
                        _currentStatusCard(context),

                        const SizedBox(height: 24),

                        _statusTimeline(context),
                      ],
                    ),
                  ),
                ],
              ),

            // MOBILE / TABLET

            if (isMobile)
              Column(
                children: [
                  _complaintImage(context),

                  const SizedBox(height: 20),

                  _currentStatusCard(context),

                  const SizedBox(height: 20),

                  _statusTimeline(context),

                  const SizedBox(height: 20),

                  _complaintInformation(context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // COMPLAINT IMAGE

  Widget _complaintImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final value = context.read<AdminProvider>();

    final detailComplaint = value.complaintDetail;

    final images = detailComplaint?.image ?? [];

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),

      child: SizedBox(
        width: double.infinity,

        height: screenWidth < 600 ? 250 : 385,

        child: Image.network(
          images.isNotEmpty ? images[0] : '',

          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              image,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  // CURRENT STATUS

  Widget _currentStatusCard(BuildContext context) {
    final value = context.read<AdminProvider>();

    final detailComplaint = value.complaintDetail;

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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Current Status',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          _statusBadge(
            context,
            detailComplaint?.status ?? status,
            const Color(0xFFE3F2FD),
            Colors.blue,
          ),

          const SizedBox(height: 25),

          const Text(
            'Update Complaint Status',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,

            height: 38,

            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(9),

              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),

            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value:
                    value.selectedComplaintStatus ??
                    detailComplaint?.status ??
                    status,

                isExpanded: true,

                items: const [
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text('Pending'),
                  ),

                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('In Progress'),
                  ),

                  DropdownMenuItem(
                    value: 'Completed',
                    child: Text('Completed'),
                  ),
                ],

                onChanged: (value) {
                  context
                      .read<AdminProvider>()
                      .setSelectedDetailStatus(value);
                },
              ),
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,

            height: 37,

            child: ElevatedButton(
              onPressed: () async {
                final success =
                    await value.updateComplaintStatus(id);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Complaint status updated successfully',
                      ),
                    ),
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),

              child: const Text(
                'Update Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // COMPLAINT INFORMATION

  Widget _complaintInformation(BuildContext context) {
    final value = context.read<AdminProvider>();

    final detailComplaint = value.complaintDetail;

    final double screenWidth =
        MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600;

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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Complaint Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(
                  child: _leftInformation(context),
                ),

                const SizedBox(width: 35),

                Expanded(
                  child: _rightInformation(context),
                ),
              ],
            ),

          if (isMobile)
            Column(
              children: [
                _leftInformation(context),

                const SizedBox(height: 15),

                _rightInformation(context),
              ],
            ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: const Color(0xFFF7F9F8),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  detailComplaint?.description ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF07152B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LEFT INFORMATION

  Widget _leftInformation(BuildContext context) {
    final value = context.read<AdminProvider>();

    final detailComplaint = value.complaintDetail;

    return Column(
      children: [
        _informationItem(
          context,
          Icons.local_offer_outlined,
          'Complaint ID',
          detailComplaint?.complaintId ?? complaintId,
        ),

        const SizedBox(height: 15),

        _informationItem(
          context,
          Icons.person_outline,
          'Citizen',
          detailComplaint?.userName ?? citizen,
        ),

        const SizedBox(height: 15),

        _informationItem(
          context,
          Icons.location_on_outlined,
          'Location',
          detailComplaint?.location ?? location,
        ),

        const SizedBox(height: 15),

        _informationItem(
          context,
          Icons.location_on_outlined,
          'GPS Location',
          '${detailComplaint?.latitude ?? ''}° N, '
          '${detailComplaint?.longitude ?? ''}° E',
        ),
      ],
    );
  }

  // RIGHT INFORMATION

  Widget _rightInformation(BuildContext context) {
    final value = context.read<AdminProvider>();

    final detailComplaint = value.complaintDetail;

    return Column(
      children: [
        _informationItem(
          context,
          Icons.local_offer_outlined,
          'Complaint Title',
          detailComplaint?.title ?? title,
        ),

        const SizedBox(height: 15),

        _informationItem(
          context,
          Icons.local_offer_outlined,
          'Waste Type',
          detailComplaint?.wasteType ?? wasteType,
        ),

        const SizedBox(height: 15),

        _informationItem(
          context,
          Icons.calendar_today_outlined,
          'Submitted Date',
          detailComplaint?.createdAt ?? date,
        ),
      ],
    );
  }

  // INFORMATION ITEM

  Widget _informationItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: 34,
          height: 34,

          decoration: BoxDecoration(
            color: const Color(0xFFEAF7EE),

            borderRadius: BorderRadius.circular(10),
          ),

          child: Icon(
            icon,
            size: 18,
            color: AppColors.primaryColor,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF07152B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STATUS TIMELINE

  Widget _statusTimeline(BuildContext context) {
    final value = context.read<AdminProvider>();

    final detailComplaint = value.complaintDetail;

    final currentStatus =
        detailComplaint?.status ?? status;

    final submittedCompleted = true;

    final pendingCompleted =
        currentStatus == 'Pending' ||
        currentStatus == 'In Progress' ||
        currentStatus == 'Completed';

    final inProgressCompleted =
        currentStatus == 'In Progress' ||
        currentStatus == 'Completed';

    final completedCompleted =
        currentStatus == 'Completed';

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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            'Status Timeline',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          _timelineItem(
            context,
            'Submitted',
            submittedCompleted,
            currentStatus == 'Submitted',
            '1',
          ),

          _timelineItem(
            context,
            'Pending',
            pendingCompleted,
            currentStatus == 'Pending',
            '2',
          ),

          _timelineItem(
            context,
            'In Progress',
            inProgressCompleted,
            currentStatus == 'In Progress',
            '3',
          ),

          _timelineItem(
            context,
            'Completed',
            completedCompleted,
            currentStatus == 'Completed',
            '4',
          ),
        ],
      ),
    );
  }

  // TIMELINE ITEM

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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,

                decoration: BoxDecoration(
                  color: current
                      ? AppColors.primaryColor
                      : completed
                          ? const Color(0xFFF4FBF6)
                          : const Color(0xFFF3F5F6),

                  shape: BoxShape.circle,

                  border: Border.all(
                    color: current
                        ? AppColors.primaryColor
                        : completed
                            ? AppColors.primaryColor
                            : const Color(0xFFDCE3E7),
                  ),
                ),

                child: Center(
                  child: completed
                      ? Icon(
                          Icons.check,
                          size: 16,
                          color: current
                              ? Colors.white
                              : AppColors.primaryColor,
                        )
                      : Text(
                          number,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                ),
              ),

              if (title != 'Completed')
                Expanded(
                  child: Container(
                    width: 1,
                    color: AppColors.primaryColor,
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          Padding(
            padding: const EdgeInsets.only(top: 5),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: current
                        ? FontWeight.w500
                        : FontWeight.w400,
                    color: current
                        ? AppColors.primaryColor
                        : const Color(0xFF334155),
                  ),
                ),

                if (current)
                  const Text(
                    'Current status',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STATUS BADGE

  Widget _statusBadge(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}