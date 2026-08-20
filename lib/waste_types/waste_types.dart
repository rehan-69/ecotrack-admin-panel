import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';

class WasteTypesScreen extends StatelessWidget {
  const WasteTypesScreen({super.key});

  static const double minTableWidth = 988;
  static const double minScreenWidth = 1100;

  @override
  Widget build(BuildContext context) {
    double screenWidth = context.width - 50;

    if (screenWidth < minScreenWidth) {
      screenWidth = minScreenWidth;
    }

    return Container(
      color: const Color(0xFFF8FAF9),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: SizedBox(
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 17,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.height * 0.020,
                  ),

                  // PAGE HEADER

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE + SUBTITLE

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Waste Types',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF07152B),
                              height: 1.1,
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

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

                      const Spacer(),

                      // ADD WASTE TYPE BUTTON

                      SizedBox(
                        width: 164,
                        height: 36,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                          label: const Text(
                            'Add Waste Type',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 23,
                  ),

                  // TABLE

                  _wasteTypeTable(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // WASTE TYPE TABLE

  Widget _wasteTypeTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tableWidth =
            constraints.maxWidth < minTableWidth
                ? minTableWidth
                : constraints.maxWidth;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFDCE3E7),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.035,
                ),
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                width: tableWidth,
                child: Column(
                  children: [
                    // TABLE HEADER

                    _tableHeader(
                      tableWidth,
                    ),

                    // HOUSEHOLD WASTE

                    _wasteRow(
                      tableWidth,
                      'Household Waste',
                      'Daily kitchen and domestic waste from homes.',
                      '42',
                      'Active',
                      false,
                    ),

                    // PLASTIC WASTE

                    _wasteRow(
                      tableWidth,
                      'Plastic Waste',
                      'Bottles, wrappers and polythene litter.',
                      '28',
                      'Active',
                      false,
                    ),

                    // CONSTRUCTION DEBRIS

                    _wasteRow(
                      tableWidth,
                      'Construction Debris',
                      'Bricks, sand, concrete and building material.',
                      '19',
                      'Active',
                      false,
                    ),

                    // GARDEN WASTE

                    _wasteRow(
                      tableWidth,
                      'Garden Waste',
                      'Leaves, branches and garden trimmings.',
                      '16',
                      'Active',
                      true,
                    ),

                    // E-WASTE

                    _wasteRow(
                      tableWidth,
                      'E-Waste',
                      'Discarded electronics, batteries and cables.',
                      '14',
                      'Active',
                      false,
                    ),

                    // OTHER

                    _wasteRow(
                      tableWidth,
                      'Other',
                      'Any waste that does not fit other categories.',
                      '9',
                      'Inactive',
                      false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // TABLE HEADER

  Widget _tableHeader(double width) {
    return Container(
      width: width,
      height: 41,
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          // WASTE TYPE

          Expanded(
            flex: 18,
            child: _headerCell(
              'WASTE TYPE',
            ),
          ),

          // DESCRIPTION

          Expanded(
            flex: 36,
            child: _headerCell(
              'DESCRIPTION',
            ),
          ),

          // TOTAL COMPLAINTS

          Expanded(
            flex: 16,
            child: _headerCell(
              'TOTAL COMPLAINTS',
            ),
          ),

          // STATUS

          Expanded(
            flex: 10,
            child: _headerCell(
              'STATUS',
            ),
          ),

          // ACTIONS

          Expanded(
            flex: 20,
            child: _headerCell(
              'ACTIONS',
            ),
          ),
        ],
      ),
    );
  }

  // HEADER CELL

  Widget _headerCell(String text) {
    return SizedBox(
      height: 41,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
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

  // WASTE ROW

  Widget _wasteRow(
    double width,
    String wasteType,
    String description,
    String complaints,
    String status,
    bool highlighted,
  ) {
    return Container(
      width: width,
      height: 59,
      decoration: BoxDecoration(
        color: highlighted
            ? const Color(0xFFF4FBF6)
            : Colors.white,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFDDE3E8),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // WASTE TYPE

          Expanded(
            flex: 18,
            child: _dataCell(
              wasteType,
              bold: true,
            ),
          ),

          // DESCRIPTION

          Expanded(
            flex: 36,
            child: _dataCell(
              description,
              textColor: const Color(0xFF64748B),
            ),
          ),

          // TOTAL COMPLAINTS

          Expanded(
            flex: 16,
            child: _dataCell(
              complaints,
            ),
          ),

          // STATUS

          Expanded(
            flex: 10,
            child: SizedBox(
              height: 59,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'Active'
                        ? const Color(0xFFD8F4DE)
                        : const Color(0xFFF0F3F2),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: status == 'Active'
                          ? const Color(0xFF16803C)
                          : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ACTIONS

          Expanded(
            flex: 20,
            child: SizedBox(
              height: 59,
              child: Row(
                children: [
                  // EDIT BUTTON

                  SizedBox(
                    width: 73,
                    height: 34,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 16,
                      ),
                      label: const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            AppColors.primaryColor,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        side: const BorderSide(
                          color: Color(0xFFDCE3E7),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  // DELETE BUTTON

                  SizedBox(
                    width: 92,
                    height: 34,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 16,
                      ),
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
                          borderRadius:
                              BorderRadius.circular(10),
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

  // DATA CELL

  Widget _dataCell(
    String text, {
    bool bold = false,
    Color textColor =
        const Color(0xFF07152B),
  }) {
    return SizedBox(
      height: 59,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold
                  ? FontWeight.w600
                  : FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}