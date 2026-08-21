import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecotrack_admin_panel/app.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AdminProvider(),
      child: const EcoTrackAdmin(),
    ),
  );
}
