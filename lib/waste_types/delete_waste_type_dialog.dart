import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';

class DeleteWasteTypeDialog extends StatelessWidget {
  const DeleteWasteTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF7FAF8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: context.width < 600
            ? context.width * 0.90
            : 520,
        padding: EdgeInsets.all(
          context.width < 600 ? 18 : 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Delete Waste Type?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              'Are you sure you want to delete this waste type?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize:
                        const Size(84, 38),
                    side: const BorderSide(
                      color: Color(0xFF2E7D32),
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          const Color(0xFF1F2937),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 8,
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(77, 38),
                    backgroundColor:
                        const Color(0xFFE51C23),
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w500,
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