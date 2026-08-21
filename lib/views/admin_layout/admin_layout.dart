import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecotrack_admin_panel/users/users_screen.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/views/widgets/side_bar.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:ecotrack_admin_panel/complaints/complaints_screen.dart';
import 'package:ecotrack_admin_panel/waste_types/waste_types_screen.dart';
import 'package:ecotrack_admin_panel/views/dashboard/dashboard_screen.dart';



class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        final bool isMobile = context.width < 900;

        if (isMobile) {
          return Scaffold(
            backgroundColor: const Color(0xFFFDF7FD),

            drawer: Drawer(
              width: 280,
              backgroundColor: Colors.white,
              child: SideBar(
                selectedIndex: value.selectedIndex,
                onItemSelected: (index) {
                  value.changeIndex(index);
                  Navigator.pop(context);
                },
              ),
            ),

            appBar: _mobileHeader(context),

            body: _getScreen(
              value.selectedIndex,
            ),
          );
        }

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
                    _desktopHeader(context),

                    Expanded(
                      child: _getScreen(
                        value.selectedIndex,
                      ),
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

  // ------------------------------------------------------------
  // DESKTOP HEADER
  // ------------------------------------------------------------

  Widget _desktopHeader(BuildContext context) {
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
              fontSize: 16,
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'admin@ecotrack.gov.in',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFE8F5E9),
            child: Text(
              'AD',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // MOBILE HEADER
  // ------------------------------------------------------------

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
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),

      title: const Text(
        'Admin Panel',
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),

      titleSpacing: 0,
    );
  }

  // ------------------------------------------------------------
  // SCREEN SWITCHING
  // ------------------------------------------------------------

  Widget _getScreen(int selectedIndex) {
    if (selectedIndex == 0) {
      return const DashboardScreen();
    }

    if (selectedIndex == 1) {
      return const ComplaintsScreen();
    }

    if (selectedIndex == 2) {
      return const UsersScreen();
    }

    if (selectedIndex == 3) {
      return const WasteTypesScreen();
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