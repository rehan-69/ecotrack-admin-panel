import 'package:ecotrack_admin_panel/complaints/complaints_screen.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:ecotrack_admin_panel/views/dashboard/dashboard_screen.dart';
import 'package:ecotrack_admin_panel/views/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Row(
            children: [
              SideBar(
                selectedIndex: value.selectedIndex,
                onItemSelected: (index) {
                  value.changeIndex(index);
                },
              ),

              Expanded(
                child: Column(
                  children: [
                    _header(context),

                    Expanded(
                      child: _getScreen(value.selectedIndex),
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

  Widget _header(BuildContext context) {
    return Container(
      height: context.height * 0.09,
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.018,
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
              fontSize: context.width * 0.012,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Spacer(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: context.width * 0.011,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'admin@ecotrack.gov.in',
                style: TextStyle(
                  fontSize: context.width * 0.008,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          SizedBox(width: context.width * 0.01),

          CircleAvatar(
            radius: context.width * 0.014,
            backgroundColor: const Color(0xFFE8F5E9),
            child: Text(
              'AD',
              style: TextStyle(
                fontSize: context.width * 0.008,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getScreen(int selectedIndex) {
    if (selectedIndex == 0) {
      return const DashboardScreen();
    }

    if (selectedIndex == 1) {
    return const ComplaintsScreen();
  }

    return const Center(
      child: Text(
        'Coming Soon',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}