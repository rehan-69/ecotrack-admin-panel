import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/views/admin_layout/admin_layout.dart';
import 'package:ecotrack_admin_panel/views/widgets/custom_button.dart';
import 'package:ecotrack_admin_panel/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: context.width * 0.40,
          padding: EdgeInsets.all(context.width * 0.030),
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

              const SizedBox(height: 10),

              const Text(
                'Admin Panel',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: context.height * 0.030),

              CustomTextField(
                title: 'Admin Email',
                width: context.width * 0.35,
                height: context.height * 0.065,
                fontSize: context.width * 0.012,
                borderRadius: context.width * 0.008,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),

              SizedBox(height: context.height * 0.020),

              CustomTextField(
                title: 'Password',
                width: context.width * 0.35,
                height: context.height * 0.065,
                fontSize: context.width * 0.012,
                borderRadius: context.width * 0.008,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: context.height * 0.025),

              CustomButton(
                text: 'Login',
                  onPressed:() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminLayout(),
                      ),
                    );
                },
                width: context.width * 0.35,
                height: context.height * 0.065,
                borderRadius: context.width * 0.008,
                fontSize: context.width * 0.012,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
