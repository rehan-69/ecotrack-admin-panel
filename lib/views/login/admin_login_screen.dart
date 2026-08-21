import 'package:ecotrack_admin_panel/views/admin_layout/admin_layout.dart';
import 'package:ecotrack_admin_panel/views/widgets/custom_button.dart';
import 'package:ecotrack_admin_panel/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    final screenHeight =
        MediaQuery.of(context).size.height;

    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Center(
        child: Container(
          width: isMobile
              ? screenWidth * 0.90
              : screenWidth * 0.40,
          padding: EdgeInsets.all(
            isMobile
                ? 20
                : screenWidth * 0.030,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'EcoTrack',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                'Admin Panel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(
                height: isMobile
                    ? 22
                    : screenHeight * 0.030,
              ),

              CustomTextField(
                title: 'Admin Email',
                width: isMobile
                    ? double.infinity
                    : screenWidth * 0.35,
                height: isMobile
                    ? 52
                    : screenHeight * 0.065,
                fontSize: 16,
                borderRadius: isMobile
                    ? 10
                    : screenWidth * 0.008,
                keyboardType:
                    TextInputType.emailAddress,
                prefixIcon:
                    Icons.email_outlined,
              ),

              SizedBox(
                height: isMobile
                    ? 16
                    : screenHeight * 0.020,
              ),

              CustomTextField(
                title: 'Password',
                width: isMobile
                    ? double.infinity
                    : screenWidth * 0.35,
                height: isMobile
                    ? 52
                    : screenHeight * 0.065,
                fontSize: 16,
                borderRadius: isMobile
                    ? 10
                    : screenWidth * 0.008,
                obscureText: true,
                prefixIcon:
                    Icons.lock_outline,
              ),

              SizedBox(
                height: isMobile
                    ? 20
                    : screenHeight * 0.025,
              ),

              CustomButton(
                text: 'Login',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AdminLayout(),
                    ),
                  );
                },
                width: isMobile
                    ? double.infinity
                    : screenWidth * 0.35,
                height: isMobile
                    ? 52
                    : screenHeight * 0.065,
                borderRadius: isMobile
                    ? 10
                    : screenWidth * 0.008,
                fontSize: 16,
                fontWeight:
                    FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}