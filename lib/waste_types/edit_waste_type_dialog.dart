import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';

class EditWasteTypeDialog extends StatelessWidget {
  final String wasteType;
  final String description;
  final String status;

  const EditWasteTypeDialog({
    super.key,
    required this.wasteType,
    required this.description,
    required this.status,
  });

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
            Row(
              children: [
                Text(
                  'Edit Waste Type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 4,
            ),

            Text(
              'Update the details of this waste category.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              'Waste Type Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            TextField(
              controller: TextEditingController(
                text: wasteType,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. Household Waste',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                        AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            TextField(
              controller: TextEditingController(
                text: description,
              ),
              maxLines: 3,
              decoration: InputDecoration(
                hintText:
                    'Short description of this waste category',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                contentPadding:
                    const EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                        AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            Text(
              'Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 6,
            ),

            Container(
              width: double.infinity,
              height: 38,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.04,
                    ),
                    blurRadius: 4,
                    offset:
                        const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  const Spacer(),

                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                ],
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
                  style:
                      OutlinedButton.styleFrom(
                    minimumSize:
                        const Size(82, 38),
                    side: BorderSide(
                      color:
                          Colors.grey.shade300,
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
                      color:
                          const Color(0xFF1F2937),
                      fontSize: 14,
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
                  style:
                      ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(65, 38),
                    backgroundColor:
                        AppColors.primaryColor,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
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