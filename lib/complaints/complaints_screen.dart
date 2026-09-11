import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:ecotrack_admin_panel/complaints/complaints_detail_screen.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  String? _getComplaintImage(dynamic image) {
    if (image == null) return null;

    if (image is List && image.isNotEmpty) {
      return image.first.toString();
    }

    if (image is String && image.isNotEmpty) {
      return image;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, provider, child) {
        if (!provider.complaintsLoaded && !provider.complaintsLoading) {
          Future.microtask(() {
            provider.loadComplaints();
          });
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(context.width * 0.018),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Complaints',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: context.height * 0.008),

              Text(
                'View and manage citizen waste complaints.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),

              SizedBox(height: context.height * 0.025),

              _filters(context, provider),

              SizedBox(height: context.height * 0.025),

              _complaintsTable(context),
            ],
          ),
        );
      },
    );
  }

  Widget _filters(BuildContext context, AdminProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 448,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          provider.setComplaintSearch(value);
                          provider.loadComplaints();
                        },
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF334155),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search by complaint ID, title or citizen',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    _dropdown(
                      context,
                      provider.selectedWasteType ?? 'All Waste Types',
                      provider.complaintWasteTypes.isEmpty
                          ? ['All Waste Types']
                          : provider.complaintWasteTypes,
                      (value) {
                        provider.setComplaintWasteType(
                          value == 'All Waste Types' ? null : value,
                        );
                        provider.loadComplaints();
                      },
                    ),

                    const SizedBox(width: 10),

                    _dropdown(
                      context,
                      provider.selectedWard ?? 'All Wards',
                      provider.complaintWards.isEmpty
                          ? ['All Wards']
                          : provider.complaintWards,
                      (value) {
                        provider.setComplaintWard(
                          value == 'All Wards' ? null : value,
                        );
                        provider.loadComplaints();
                      },
                    ),

                    const SizedBox(width: 10),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _filterButton(
                      context,
                      'All',
                      provider.selectedStatus == null,
                      () {
                        provider.setComplaintStatus(null);
                      },
                    ),

                    const SizedBox(width: 10),

                    _filterButton(
                      context,
                      'Pending',
                      provider.selectedStatus == 'Pending',
                      () {
                        provider.setComplaintStatus('Pending');
                      },
                    ),

                    const SizedBox(width: 10),

                    _filterButton(
                      context,
                      'In Progress',
                      provider.selectedStatus == 'In Progress',
                      () {
                        provider.setComplaintStatus('In Progress');
                      },
                    ),

                    const SizedBox(width: 10),

                    _filterButton(
                      context,
                      'Completed',
                      provider.selectedStatus == 'Completed',
                      () {
                        provider.setComplaintStatus('Completed');
                      },
                    ),
                  ],
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    provider.setComplaintSearch(value);
                    provider.loadComplaints();
                  },
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF334155),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by complaint ID, title or citizen',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _dropdown(
                    context,
                    provider.selectedWasteType ?? 'All Waste Types',
                    provider.complaintWasteTypes.isEmpty
                        ? ['All Waste Types']
                        : provider.complaintWasteTypes,
                    (value) {
                      provider.setComplaintWasteType(
                        value == 'All Waste Types' ? null : value,
                      );
                      provider.loadComplaints();
                    },
                  ),

                  _dropdown(
                    context,
                    provider.selectedWard ?? 'All Wards',
                    provider.complaintWards.isEmpty
                        ? ['All Wards']
                        : provider.complaintWards,
                    (value) {
                      provider.setComplaintWard(
                        value == 'All Wards' ? null : value,
                      );
                      provider.loadComplaints();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _filterButton(
                    context,
                    'All',
                    provider.selectedStatus == null,
                    () {
                      provider.setComplaintStatus(null);
                    },
                  ),

                  const SizedBox(width: 15),

                  _filterButton(
                    context,
                    'Pending',
                    provider.selectedStatus == 'Pending',
                    () {
                      provider.setComplaintStatus('Pending');
                    },
                  ),

                  const SizedBox(width: 15),

                  _filterButton(
                    context,
                    'In Progress',
                    provider.selectedStatus == 'In Progress',
                    () {
                      provider.setComplaintStatus('In Progress');
                    },
                  ),

                  const SizedBox(width: 15),

                  _filterButton(
                    context,
                    'Completed',
                    provider.selectedStatus == 'Completed',
                    () {
                      provider.setComplaintStatus('Completed');
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterButton(
    BuildContext context,
    String text,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primaryColor : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: selected ? Colors.white : Colors.grey.shade700,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _dropdown(
    BuildContext context,
    String selectedValue,
    List<String> items,
    Function(String) onSelected,
  ) {
    return SizedBox(
      width: 170,
      height: 40,
      child: PopupMenuButton<String>(
        initialValue: selectedValue,
        onSelected: onSelected,
        position: PopupMenuPosition.under,
        offset: Offset.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: 4,
        itemBuilder: (context) {
          return items.map((type) {
            final isSelected = type == selectedValue;

            return PopupMenuItem<String>(
              value: type,
              height: 32,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE8F5E9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        type,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected
                              ? AppColors.primaryColor
                              : const Color(0xFF374151),
                          fontWeight: isSelected
                              ? FontWeight.w500
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                  ],
                ),
              ),
            );
          }).toList();
        },
        child: Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _complaintsTable(BuildContext context) {
    final provider = context.watch<AdminProvider>();

    double tableWidth = context.width < 1200 ? 1200 : context.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: tableWidth,
          child: Column(
            children: [
              _tableHeader(context, tableWidth),

              if (provider.complaintsLoading)
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: CircularProgressIndicator(),
                )
              else if (provider.complaintsError != null)
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    provider.complaintsError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (provider.complaints.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'No complaints found',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                ...provider.complaints.map((complaint) {
                  final status = complaint['status']?.toString() ?? 'Pending';

                  Color statusColor = Colors.orange;
                  Color statusBackground = const Color(0xFFFFF0CC);

                  if (status.toLowerCase() == 'in progress') {
                    statusColor = Colors.blue;
                    statusBackground = const Color(0xFFE3F2FD);
                  } else if (status.toLowerCase() == 'completed') {
                    statusColor = Colors.green;
                    statusBackground = const Color(0xFFE0F5E5);
                  }

                  return _tableRow(
                    context,
                    tableWidth,
                    complaint['complaint_id']?.toString() ?? '',
                    _getComplaintImage(complaint['image']) ?? '',
                    complaint['title']?.toString() ?? '',
                    complaint['user_name']?.toString() ?? 'Unknown',
                    complaint['waste_type']?.toString() ?? '',
                    complaint['ward']?.toString() ??
                        complaint['location']?.toString() ??
                        '',
                    _formatDate(complaint['created_at']),
                    status,
                    statusColor,
                    statusBackground,
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeader(BuildContext context, double tableWidth) {
    return Container(
      height: 58,
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          _headerCell(context, 'COMPLAINT\nID', tableWidth * 0.10),
          _headerCell(context, 'PHOTO', tableWidth * 0.08),
          _headerCell(context, 'COMPLAINT TITLE', tableWidth * 0.15),
          _headerCell(context, 'CITIZEN', tableWidth * 0.12),
          _headerCell(context, 'WASTE TYPE', tableWidth * 0.14),
          _headerCell(context, 'WARD /\nLOCATION', tableWidth * 0.12),
          _headerCell(context, 'SUBMITTED\nDATE', tableWidth * 0.12),
          _headerCell(context, 'STATUS', tableWidth * 0.09),
          _headerCell(context, 'ACTION', tableWidth * 0.08),
        ],
      ),
    );
  }

  Widget _headerCell(BuildContext context, String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
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

  Widget _tableRow(
    BuildContext context,
    double tableWidth,
    String id,
    String image,
    String title,
    String citizen,
    String wasteType,
    String location,
    String date,
    String status,
    Color statusColor,
    Color statusBackground,
  ) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _dataCell(context, id, tableWidth * 0.10),

          SizedBox(
            width: tableWidth * 0.08,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: image.isEmpty
                    ? Image.asset(
                        'assets/waste-household.jpg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      )
                    : image.startsWith('http://') ||
                          image.startsWith('https://')
                    ? Image.network(
                        image,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/waste-household.jpg',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        image,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          _dataCell(context, title, tableWidth * 0.15),

          _dataCell(context, citizen, tableWidth * 0.12),

          _dataCell(context, wasteType, tableWidth * 0.14),

          _dataCell(context, location, tableWidth * 0.12),

          _dataCell(context, date, tableWidth * 0.12),

          SizedBox(
            width: tableWidth * 0.09,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            width: tableWidth * 0.08,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintDetailScreen(
                      complaintId: id,
                      image: image,
                      title: title,
                      citizen: citizen,
                      wasteType: wasteType,
                      location: location,
                      date: date,
                      status: status,
                    ),
                  ),
                );
              },
              child: Text(
                'View',
                style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataCell(BuildContext context, String text, double width) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
        ),
      ),
    );
  }

  String _formatDate(dynamic value) {
    if (value == null) return '';

    try {
      final date = DateTime.parse(value.toString());

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
    } catch (e) {
      return value.toString();
    }
  }
}
