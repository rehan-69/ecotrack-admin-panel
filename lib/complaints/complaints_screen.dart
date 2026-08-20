import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/complaints/complaints_detail_screen.dart';
import 'package:flutter/material.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.width * 0.018),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complaints',
            style: TextStyle(
              fontSize: context.width * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: context.height * 0.008,
          ),

          Text(
            'View and manage citizen waste complaints.',
            style: TextStyle(
              fontSize: context.width * 0.011,
              color: Colors.grey.shade600,
            ),
          ),

          SizedBox(
            height: context.height * 0.025,
          ),

          _filters(context),

          SizedBox(
            height: context.height * 0.025,
          ),

          _complaintsTable(context),
        ],
      ),
    );
  }
  Widget _filters(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
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
              // TOP ROW
              Row(
                children: [
                  // SEARCH BOX
                  SizedBox(
                    width: 448,
                    height: 40,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF334155),
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'Search by complaint ID, title or citizen',
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
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // WASTE TYPE DROPDOWN
                  _dropdown(
                    context,
                    'All Waste Types',
                  ),

                  const SizedBox(width: 10),

                  // WARD DROPDOWN
                  _dropdown(
                    context,
                    'All Wards',
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // STATUS FILTERS
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _filterButton(
                    context,
                    'All',
                    true,
                  ),

                  const SizedBox(width: 8),

                  _filterButton(
                    context,
                    'Pending',
                    false,
                  ),

                  const SizedBox(width: 8),

                  _filterButton(
                    context,
                    'In Progress',
                    false,
                  ),

                  const SizedBox(width: 8),

                  _filterButton(
                    context,
                    'Completed',
                    false,
                  ),
                ],
              ),
            ],
          );
        }

        // MOBILE / SMALL WIDTH
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 845,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 448,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              'Search by complaint ID, title or citizen',
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    _dropdown(
                      context,
                      'All Waste Types',
                    ),

                    const SizedBox(width: 10),

                    _dropdown(
                      context,
                      'All Wards',
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _filterButton(
                      context,
                      'All',
                      true,
                    ),

                    const SizedBox(width: 8),

                    _filterButton(
                      context,
                      'Pending',
                      false,
                    ),

                    const SizedBox(width: 8),

                    _filterButton(
                      context,
                      'In Progress',
                      false,
                    ),

                    const SizedBox(width: 8),

                    _filterButton(
                      context,
                      'Completed',
                      false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
Widget _filterButton(
  BuildContext context,
  String text,
  bool selected,
) {
  return Container(
    height: 38,
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    decoration: BoxDecoration(
      color: selected
          ? AppColors.primaryColor
          : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: selected
            ? AppColors.primaryColor
            : Colors.grey.shade300,
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(
        fontSize: context.width * 0.0095,
        color: selected
            ? Colors.white
            : Colors.grey.shade700,
        fontWeight: selected
            ? FontWeight.w600
            : FontWeight.w400,
      ),
    ),
  );
}

Widget _dropdown(
  BuildContext context,
  String text,
) {
  return Container(
    width: 180,
    height: 48,
    padding: const EdgeInsets.symmetric(
      horizontal: 14,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),
    child: Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: context.width * 0.0095,
            color: Colors.grey.shade700,
          ),
        ),

        const Spacer(),

        const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
        ),
      ],
    ),
  );
}
  Widget _complaintsTable(BuildContext context) {
    double tableWidth =
        context.width < 1200 ? 1200 : context.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: tableWidth,
          child: Column(
            children: [
              _tableHeader(context, tableWidth),

              _tableRow(
                context,
                tableWidth,
                'ECO-1042',
                'assets/waste-household.jpg',
                'Household Waste',
                'Rahul Sharma',
                'Household Waste',
                'Ward 07',
                '12 Mar 2026',
                'In Progress',
                Colors.blue,
                const Color(0xFFE3F2FD),
              ),

              _tableRow(
                context,
                tableWidth,
                'ECO-1038',
                'assets/waste-household.jpg',
                'Construction Debris',
                'Amit Patil',
                'Construction Debris',
                'Ward 07',
                '08 Mar 2026',
                'Completed',
                Colors.green,
                const Color(0xFFE0F5E5),
              ),

              _tableRow(
                context,
                tableWidth,
                'ECO-1031',
                'assets/waste-household.jpg',
                'Garden Waste',
                'Priya Shah',
                'Garden Waste',
                'Ward 04',
                '02 Mar 2026',
                'Completed',
                Colors.green,
                const Color(0xFFE0F5E5),
              ),

              _tableRow(
                context,
                tableWidth,
                'ECO-1025',
                'assets/waste-household.jpg',
                'Plastic Waste',
                'Sameer Khan',
                'Plastic Waste',
                'Ward 04',
                '27 Feb 2026',
                'Pending',
                Colors.orange,
                const Color(0xFFFFF0CC),
              ),

              _tableRow(
                context,
                tableWidth,
                'ECO-1019',
                'assets/waste-household.jpg',
                'E-Waste dumped near road',
                'Neha Joshi',
                'E-Waste',
                'Ward 02',
                '21 Feb 2026',
                'Pending',
                Colors.orange,
                const Color(0xFFFFF0CC),
              ),

              _tableRow(
                context,
                tableWidth,
                'ECO-1014',
                'assets/waste-household.jpg',
                'Household Waste near road',
                'Vikas Deshmukh',
                'Household Waste',
                'Ward 09',
                '16 Feb 2026',
                'In Progress',
                Colors.blue,
                const Color(0xFFE3F2FD),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeader(
    BuildContext context,
    double tableWidth,
  ) {
    return Container(
      height: 58,
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          _headerCell(
            context,
            'COMPLAINT\nID',
            tableWidth * 0.10,
          ),

          _headerCell(
            context,
            'PHOTO',
            tableWidth * 0.08,
          ),

          _headerCell(
            context,
            'COMPLAINT TITLE',
            tableWidth * 0.15,
          ),

          _headerCell(
            context,
            'CITIZEN',
            tableWidth * 0.12,
          ),

          _headerCell(
            context,
            'WASTE TYPE',
            tableWidth * 0.14,
          ),

          _headerCell(
            context,
            'WARD /\nLOCATION',
            tableWidth * 0.12,
          ),

          _headerCell(
            context,
            'SUBMITTED\nDATE',
            tableWidth * 0.12,
          ),

          _headerCell(
            context,
            'STATUS',
            tableWidth * 0.09,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: context.width * 0.0085,
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
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          _dataCell(
            context,
            id,
            tableWidth * 0.10,
          ),

          SizedBox(
            width: tableWidth * 0.08,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          _dataCell(
            context,
            title,
            tableWidth * 0.15,
          ),

          _dataCell(
            context,
            citizen,
            tableWidth * 0.12,
          ),

          _dataCell(
            context,
            wasteType,
            tableWidth * 0.14,
          ),

          _dataCell(
            context,
            location,
            tableWidth * 0.12,
          ),

          _dataCell(
            context,
            date,
            tableWidth * 0.12,
          ),

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
                    fontSize: context.width * 0.0085,
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
                    builder: (context) =>
                        ComplaintDetailScreen(
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
                style: TextStyle(
                  fontSize: context.width * 0.0095,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataCell(
    BuildContext context,
    String text,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: context.width * 0.0095,
            color: const Color(0xFF0F172A),
          ),
        ),
      ),
    );
  }
}