
import 'package:flutter/material.dart';

class EcoTrackAdmin extends StatelessWidget {
  const EcoTrackAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoTrack Admin Panel',
      home: const AdminLoginScreen(),
    );
  }
}