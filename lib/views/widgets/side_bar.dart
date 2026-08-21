import 'package:ecotrack_admin_panel/constants/app_color.dart';
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
      width: 220,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.eco,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'EcoTrack',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Admin Panel',
                        style: TextStyle(
                          fontSize: 11,
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
              height: 1,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MANAGEMENT',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

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
              height: 1,
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 15,
                      color: Colors.grey.shade700,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    int index,
    IconData icon,
    String title,
  ) {
    final bool isSelected =
        selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      child: InkWell(
        onTap: () {
          onItemSelected(index);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
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
                size: 15,
                color: isSelected
                    ? Colors.white
                    : Colors.grey.shade600,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}