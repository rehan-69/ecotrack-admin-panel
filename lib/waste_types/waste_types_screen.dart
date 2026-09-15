import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/viewmodel/admin_provider.dart';
import 'package:ecotrack_admin_panel/models/waste_type_model.dart';

import 'package:ecotrack_admin_panel/waste_types/add_waste_type_dialog.dart';
import 'package:ecotrack_admin_panel/waste_types/edit_waste_type_dialog.dart';
import 'package:ecotrack_admin_panel/waste_types/delete_waste_type_dialog.dart';

class WasteTypesScreen extends StatelessWidget {
  const WasteTypesScreen({super.key});

  static const double minTableWidth = 988;

  String _formatDate(String value) {
    try {
      final date = DateTime.parse(value).toLocal();

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${date.day.toString().padLeft(2, '0')} '
          '${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;

    final provider = context.watch<AdminProvider>();

    if (!provider.adminWasteTypesLoading &&
        !provider.adminWasteTypesLoaded &&
        provider.adminWasteTypesError == null) {
      Future.microtask(() {
        provider.loadWasteTypes();
      });
    }

    return Container(
      color: const Color(0xFFF8FAF9),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
            left: isMobile ? 16 : 25,
            right: isMobile ? 16 : 25,
            top: 17,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.020),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Waste Types',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF07152B),
                            height: 1.1,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Manage waste categories used for citizen complaints.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF64748B),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),

                  SizedBox(
                    width: 164,
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return const AddWasteTypeDialog();
                          },
                        );

                        provider.loadWasteTypes();
                      },
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text(
                        'Add Waste Type',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 23),

              _wasteTypeTable(context, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wasteTypeTable(BuildContext context, AdminProvider provider) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFDCE3E7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tableWidth = constraints.maxWidth < minTableWidth
                ? minTableWidth
                : constraints.maxWidth;

            if (provider.adminWasteTypesLoading) {
              return SizedBox(
                width: tableWidth,
                height: 150,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            if (provider.adminWasteTypesError != null) {
              return SizedBox(
                width: tableWidth,
                height: 150,
                child: Center(
                  child: Text(
                    provider.adminWasteTypesError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              );
            }

            if (provider.wasteTypes.isEmpty) {
              return SizedBox(
                width: tableWidth,
                height: 150,
                child: const Center(
                  child: Text(
                    'No waste types found',
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                width: tableWidth,
                child: Column(
                  children: [
                    _tableHeader(context, tableWidth),

                    ...provider.wasteTypes.map(
                      (wasteType) => _wasteRow(context, tableWidth, wasteType),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _tableHeader(BuildContext context, double width) {
    return Container(
      width: width,
      height: 41,
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          Expanded(flex: 20, child: _headerCell(context, 'WASTE TYPE')),

          Expanded(flex: 38, child: _headerCell(context, 'DESCRIPTION')),

          Expanded(flex: 17, child: _headerCell(context, 'TOTAL COMPLAINTS')),

          Expanded(flex: 15, child: _headerCell(context, 'ADDED DATE')),

          Expanded(flex: 25, child: _headerCell(context, 'ACTIONS')),
        ],
      ),
    );
  }

  Widget _headerCell(BuildContext context, String text) {
    return SizedBox(
      height: 41,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wasteRow(
    BuildContext context,
    double width,
    WasteTypeModel wasteType,
  ) {
    return Container(
      width: width,
      height: 59,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFDDE3E8), width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: _dataCell(context, wasteType.name, bold: true),
          ),

          Expanded(
            flex: 38,
            child: _dataCell(
              context,
              wasteType.description,
              textColor: const Color(0xFF64748B),
            ),
          ),

          Expanded(
            flex: 17,
            child: _dataCell(context, wasteType.complaintCount.toString()),
          ),
          Expanded(
            flex: 15,
            child: _dataCell(context, _formatDate(wasteType.createdAt)),
          ),

          Expanded(
            flex: 25,
            child: SizedBox(
              height: 59,
              child: Row(
                children: [
                  SizedBox(
                    width: 73,
                    height: 34,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return EditWasteTypeDialog(
                              id: wasteType.id,
                              wasteType: wasteType.name,
                              description: wasteType.description,
                            );
                          },
                        );

                        if (context.mounted) {
                          context.read<AdminProvider>().loadWasteTypes();
                        }
                      },
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        side: const BorderSide(
                          color: Color(0xFFDCE3E7),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  SizedBox(
                    width: 92,
                    height: 34,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteWasteTypeDialog(
                              id: wasteType.id,
                              wasteType: wasteType.name,
                            );
                          },
                        );

                        if (context.mounted) {
                          context.read<AdminProvider>().loadWasteTypes();
                        }
                      },
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        side: const BorderSide(
                          color: Color(0xFFDCE3E7),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataCell(
    BuildContext context,
    String text, {
    bool bold = false,
    Color textColor = const Color(0xFF07152B),
  }) {
    return SizedBox(
      height: 59,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
