import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecotrack_admin_panel/views/login/admin_login_screen.dart';
import 'package:provider/provider.dart';

class EcoTrackAdmin extends StatelessWidget {
  const EcoTrackAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AdminProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EcoTrack Admin Panel',
        home: const AdminLoginScreen(),
      ),
    );
  }
}