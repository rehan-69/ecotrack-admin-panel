import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
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
                child: Center(
                  child: Text(
                    'Admin Content',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}