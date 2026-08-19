import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _chartBar(
                  context,
                  'Pending',
                  24,
                  Colors.orange,
                ),

                _chartBar(
                  context,
                  'In Progress',
                  31,
                  Colors.blue,
                ),

                _chartBar(
                  context,
                  'Completed',
                  73,
                  AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartBar(
    BuildContext context,
    String title,
    int value,
    Color color,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: context.width * 0.045,
          height: context.height * 0.20 * (value / 80),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
        ),

        SizedBox(height: context.height * 0.01),

        Text(
          title,
          style: TextStyle(
            fontSize: context.width * 0.009,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}