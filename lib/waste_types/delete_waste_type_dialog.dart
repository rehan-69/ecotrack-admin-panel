import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';

class DeleteWasteTypeDialog extends StatelessWidget {
  final int id;
  final String wasteType;

  const DeleteWasteTypeDialog({
    super.key,
    required this.id,
    required this.wasteType,
  });

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
            const Text(
              'Delete Waste Type?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            Text(
              'Are you sure you want to delete "$wasteType"?',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(84, 38),
                    side: const BorderSide(color: Color(0xFF2E7D32)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () async {
                    final provider = context.read<AdminProvider>();

                    final success = await provider.deleteWasteType(id);

                    if (!context.mounted) {
                      return;
                    }

                    if (success) {
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            provider.adminWasteTypesError ??
                                'Failed to delete waste type',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(77, 38),
                    backgroundColor: const Color(0xFFE51C23),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
