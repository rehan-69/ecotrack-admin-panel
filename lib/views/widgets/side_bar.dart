import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SideBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const SideBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.19,
      height: context.height,
      color: AppColors.darkGreen,
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.015,
        vertical: context.height * 0.025,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EcoTrack',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: context.width * 0.015,
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            'Admin Panel',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: context.width * 0.009,
            ),
          ),

          SizedBox(height: context.height * 0.045),

          Text(
            'MANAGEMENT',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: context.width * 0.008,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: context.height * 0.015),

          _menuItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            index: 0,
          ),

          _menuItem(
            context,
            icon: Icons.description_outlined,
            title: 'Complaints',
            index: 1,
          ),

          _menuItem(
            context,
            icon: Icons.people_outline,
            title: 'Users',
            index: 2,
          ),

          _menuItem(
            context,
            icon: Icons.delete_outline,
            title: 'Waste Types',
            index: 3,
          ),

          const Spacer(),

          _menuItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        onItemSelected(index);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: context.height * 0.008,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.012,
          vertical: context.height * 0.014,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: context.width * 0.015,
            ),

            SizedBox(width: context.width * 0.010),

            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: context.width * 0.010,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}