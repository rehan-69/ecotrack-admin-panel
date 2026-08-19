import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';


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
      width: context.width * 0.18,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(context.width * 0.015),
            child: Row(
              children: [
                Container(
                  width: context.width * 0.032,
                  height: context.width * 0.032,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.eco,
                    color: Colors.white,
                  ),
                ),

                SizedBox(width: context.width * 0.01),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EcoTrack',
                      style: TextStyle(
                        fontSize: context.width * 0.012,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Admin Panel',
                      style: TextStyle(
                        fontSize: context.width * 0.009,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(
            color: Colors.grey.shade200,
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.012,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'MANAGEMENT',
                style: TextStyle(
                  fontSize: context.width * 0.008,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          SizedBox(height: context.height * 0.015),

          _menuItem(
            context,
            0,
            Icons.dashboard_outlined,
            'Dashboard',
          ),

          _menuItem(
            context,
            1,
            Icons.description_outlined,
            'Complaints',
          ),

          _menuItem(
            context,
            2,
            Icons.people_outline,
            'Users',
          ),

          _menuItem(
            context,
            3,
            Icons.delete_outline,
            'Waste Types',
          ),

          const Spacer(),

          Divider(
            color: Colors.grey.shade200,
          ),

          Padding(
            padding: EdgeInsets.all(context.width * 0.012),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: context.width * 0.014,
                    color: Colors.grey.shade700,
                  ),

                  SizedBox(width: context.width * 0.01),

                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: context.width * 0.011,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    int index,
    IconData icon,
    String title,
  ) {
    final isSelected = selectedIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.006,
        vertical: context.height * 0.003,
      ),
      child: InkWell(
        onTap: () {
          onItemSelected(index);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.012,
            vertical: context.height * 0.012,
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
                size: context.width * 0.014,
                color: isSelected
                    ? Colors.white
                    : Colors.grey.shade600,
              ),

              SizedBox(width: context.width * 0.01),

              Text(
                title,
                style: TextStyle(
                  fontSize: context.width * 0.011,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}