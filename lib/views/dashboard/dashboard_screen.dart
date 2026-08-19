import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: context.width * 0.022,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: context.height * 0.01),

          Text(
            'Monitor and manage waste complaints across your city.',
            style: TextStyle(
              fontSize: context.width * 0.012,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: context.height * 0.035),

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

              SizedBox(width: context.width * 0.015),

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

              SizedBox(width: context.width * 0.015),

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

              SizedBox(width: context.width * 0.015),

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

          SizedBox(height: context.height * 0.035),

          _complaintStatus(context),

          SizedBox(height: context.height * 0.035),

          _recentComplaints(context),
        ],
      ),
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
      padding: EdgeInsets.all(context.width * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
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
            width: context.width * 0.032,
            height: context.width * 0.032,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: context.width * 0.018,
            ),
          ),

          SizedBox(width: context.width * 0.012),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: context.width * 0.012,
                  color: Colors.grey.shade700,
                ),
              ),

              SizedBox(height: context.height * 0.005),

              Text(
                value,
                style: TextStyle(
                  fontSize: context.width * 0.020,
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
      padding: EdgeInsets.all(context.width * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
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
          Text(
            'Complaint Status Overview',
            style: TextStyle(
              fontSize: context.width * 0.013,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: context.height * 0.008),

          Text(
            'Distribution of complaints by current status.',
            style: TextStyle(
              fontSize: context.width * 0.010,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: context.height * 0.025),

          SizedBox(
            height: context.height * 0.30,
            child: BarChart(
              BarChartData(
                maxY: 80,
                minY: 0,
                alignment: BarChartAlignment.spaceAround,

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

                borderData: FlBorderData(
                  show: false,
                ),

                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (
                      group,
                      groupIndex,
                      rod,
                      rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.toInt().toString(),
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: context.width * 0.009,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        String title = '';

                        if (value == 0) {
                          title = 'Pending';
                        } else if (value == 1) {
                          title = 'In Progress';
                        } else if (value == 2) {
                          title = 'Completed';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: context.width * 0.009,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: [
                  _barGroup(
                    0,
                    24,
                    Colors.orange,
                  ),

                  _barGroup(
                    1,
                    31,
                    Colors.blue,
                  ),

                  _barGroup(
                    2,
                    73,
                    AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(
    int x,
    double value,
    Color color,
  ) {
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
            Text(
              'Recent Complaints',
              style: TextStyle(
                fontSize: context.width * 0.013,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            Text(
              'View All Complaints',
              style: TextStyle(
                fontSize: context.width * 0.010,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        SizedBox(height: context.height * 0.015),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _complaintHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.015,
        vertical: context.height * 0.018,
      ),
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

  Widget _tableTitle(
    BuildContext context,
    String title,
    int flex,
  ) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: TextStyle(
          fontSize: context.width * 0.0085,
          color: Colors.grey.shade700,
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
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.015,
        vertical: context.height * 0.018,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
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
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.007,
                  vertical: context.height * 0.006,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: context.width * 0.008,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 7,
            child: Text(
              'View',
              style: TextStyle(
                fontSize: context.width * 0.009,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
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
    int flex,
  ) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontSize: context.width * 0.009,
          color: Colors.black87,
        ),
      ),
    );
  }
}