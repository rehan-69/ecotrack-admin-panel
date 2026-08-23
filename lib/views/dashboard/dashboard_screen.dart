import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/complaints/complaints_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double dashboardWidth = constraints.maxWidth;
        final bool isMobile = dashboardWidth < 700;

        return SingleChildScrollView(
          padding: EdgeInsets.all(dashboardWidth * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Monitor and manage waste complaints across your city.',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              SizedBox(height: dashboardWidth * 0.035),

              if (isMobile)
                Column(
                  children: [
                    _dashboardCard(
                      context,
                      'Total Complaints',
                      '128',
                      Icons.description_outlined,
                      const Color(0xFFE8F5E9),
                      AppColors.primaryColor,
                    ),

                    const SizedBox(height: 16),

                    _dashboardCard(
                      context,
                      'Pending',
                      '24',
                      Icons.access_time,
                      const Color(0xFFFFF3D6),
                      Colors.orange,
                    ),

                    const SizedBox(height: 16),

                    _dashboardCard(
                      context,
                      'In Progress',
                      '31',
                      Icons.sync,
                      const Color(0xFFE3F2FD),
                      Colors.blue,
                    ),

                    const SizedBox(height: 16),

                    _dashboardCard(
                      context,
                      'Completed',
                      '73',
                      Icons.check_circle_outline,
                      const Color(0xFFE0F5E5),
                      Colors.green,
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _dashboardCard(
                        context,
                        'Total Complaints',
                        '128',
                        Icons.description_outlined,
                        const Color(0xFFE8F5E9),
                        AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(width: dashboardWidth * 0.015),

                    Expanded(
                      child: _dashboardCard(
                        context,
                        'Pending',
                        '24',
                        Icons.access_time,
                        const Color(0xFFFFF3D6),
                        Colors.orange,
                      ),
                    ),

                    SizedBox(width: dashboardWidth * 0.015),

                    Expanded(
                      child: _dashboardCard(
                        context,
                        'In Progress',
                        '31',
                        Icons.sync,
                        const Color(0xFFE3F2FD),
                        Colors.blue,
                      ),
                    ),

                    SizedBox(width: dashboardWidth * 0.015),

                    Expanded(
                      child: _dashboardCard(
                        context,
                        'Completed',
                        '73',
                        Icons.check_circle_outline,
                        const Color(0xFFE0F5E5),
                        Colors.green,
                      ),
                    ),
                  ],
                ),

              SizedBox(height: dashboardWidth * 0.035),

              _complaintStatus(context),

              SizedBox(height: dashboardWidth * 0.035),

              _recentComplaints(context),
            ],
          ),
        );
      },
    );
  }

  Widget _dashboardCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconBackground,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 5),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _complaintStatus(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complaint Status Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Distribution of complaints by current status.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                maxY: 80,
                minY: 0,
                alignment: BarChartAlignment.spaceEvenly,

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),

                borderData: FlBorderData(show: false),

                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toInt().toString(),
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return const Text('');
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        String title = '';

                        if (value == 0) {
                          title = 'Pending';
                        } else if (value == 1) {
                          title = 'In Progress';
                        } else if (value == 2) {
                          title = 'Completed';
                        }

                        return Text(
                          title,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: [
                  _barGroup(0, 24, Colors.orange),

                  _barGroup(1, 31, Colors.blue),

                  _barGroup(2, 73, AppColors.primaryColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double value, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 45,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }

  Widget _recentComplaints(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Recent Complaints',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            const Text(
              'View All Complaints',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth < 700
                        ? 900
                        : constraints.maxWidth,
                    child: Column(
                      children: [
                        _complaintHeader(context),

                        _complaintRow(
                          context,
                          'ECO-1042',
                          'Rahul Sharma',
                          'Household Waste',
                          'Ward 07',
                          '12 Mar 2026',
                          'In Progress',
                          Colors.blue,
                          const Color(0xFFE3F2FD),
                          'assets/waste-household.jpg',
                          'Household Waste Complaint',
                        ),

                        _complaintRow(
                          context,
                          'ECO-1038',
                          'Amit Patil',
                          'Construction Debris',
                          'Ward 07',
                          '08 Mar 2026',
                          'Completed',
                          Colors.green,
                          const Color(0xFFE0F5E5),
                          'assets/waste-household.jpg',
                          'Household Waste Complaint',
                        ),

                        _complaintRow(
                          context,
                          'ECO-1031',
                          'Priya Shah',
                          'Garden Waste',
                          'Ward 04',
                          '02 Mar 2026',
                          'Completed',
                          Colors.green,
                          const Color(0xFFE0F5E5),
                          'assets/waste-household.jpg',
                          'Household Waste Complaint',
                        ),

                        _complaintRow(
                          context,
                          'ECO-1025',
                          'Sameer Khan',
                          'Plastic Waste',
                          'Ward 04',
                          '27 Feb 2026',
                          'Pending',
                          Colors.orange,
                          const Color(0xFFFFF3D6),
                          'assets/waste-household.jpg',
                          'Household Waste Complaint',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _complaintHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          _tableTitle(context, 'COMPLAINT ID', 12),

          _tableTitle(context, 'CITIZEN', 12),

          _tableTitle(context, 'WASTE TYPE', 15),

          _tableTitle(context, 'LOCATION', 10),

          _tableTitle(context, 'DATE', 10),

          _tableTitle(context, 'STATUS', 10),

          _tableTitle(context, 'ACTION', 7),
        ],
      ),
    );
  }

  Widget _tableTitle(BuildContext context, String title, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _complaintRow(
    BuildContext context,
    String id,
    String citizen,
    String wasteType,
    String location,
    String date,
    String status,
    Color statusColor,
    Color statusBackground,
    String image,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _tableText(context, id, 12),

          _tableText(context, citizen, 12),

          _tableText(context, wasteType, 15),

          _tableText(context, location, 10),

          _tableText(context, date, 10),

          Expanded(
            flex: 10,
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

          Expanded(
            flex: 7,
            child: GestureDetector(
              onTap: () {
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
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableText(BuildContext context, String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
