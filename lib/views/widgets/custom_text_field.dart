import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotrack_admin_panel/constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final double fontSize;
  final double borderRadius;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.title,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.borderRadius,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,

        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: const Color(0xFF1F2937),
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(
          hintText: title,

          hintStyle: GoogleFonts.inter(
            fontSize: fontSize,
            color: const Color(0xFF9CA3AF),
            fontWeight: FontWeight.w400,
          ),

          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Color(0xFF79808C), size: 20)
              : null,

          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
