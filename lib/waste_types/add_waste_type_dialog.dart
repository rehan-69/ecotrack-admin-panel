import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';

class AddWasteTypeDialog extends StatefulWidget {
  const AddWasteTypeDialog({super.key});

  @override
  State<AddWasteTypeDialog> createState() => _AddWasteTypeDialogState();
}

class _AddWasteTypeDialogState extends State<AddWasteTypeDialog> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  bool isSaving = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  Future<void> _saveWasteType() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter waste type name')),
      );
      return;
    }

    if (description.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter description')));
      return;
    }

    setState(() {
      isSaving = true;
    });

    final provider = context.read<AdminProvider>();

    final success = await provider.addWasteType(
      name: name,
      description: description,
    );

    if (!mounted) return;

    setState(() {
      isSaving = false;
    });

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.adminWasteTypesError ?? 'Failed to add waste type',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    return Dialog(
      backgroundColor: const Color(0xFFF7FAF8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: isMobile ? screenWidth * 0.90 : 520,
        padding: EdgeInsets.all(isMobile ? 18 : 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Add Waste Type',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),

                const Spacer(),

                InkWell(
                  onTap: isSaving
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: const Icon(Icons.close, size: 20, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              'Create a new waste category for citizen complaints.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),

            const Text(
              'Waste Type Name',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 6),

            TextField(
              controller: nameController,
              enabled: !isSaving,
              decoration: InputDecoration(
                hintText: 'e.g. Household Waste',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Description',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 6),

            TextField(
              controller: descriptionController,
              enabled: !isSaving,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Short description of this waste category',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(82, 38),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xFF1F2937), fontSize: 14),
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: isSaving ? null : _saveWasteType,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(65, 38),
                    backgroundColor: AppColors.primaryColor,
                    disabledBackgroundColor: AppColors.primaryColor.withValues(
                      alpha: 0.6,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isSaving
                      ? const SizedBox(
                          width: 17,
                          height: 17,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
