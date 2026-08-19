import 'package:ecotrack_admin_panel/complaints/complaints_detail_screen.dart';
import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.width * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complaints',
            style: TextStyle(
              fontSize: context.width * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: context.height * 0.01),

          Text(
            'View and manage citizen waste complaints.',
            style: TextStyle(
              fontSize: context.width * 0.012,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: context.height * 0.025),

          _filters(context),

          SizedBox(height: context.height * 0.02),

          _complaintTable(context),
        ],
      ),
    );
  }

  Widget _filters(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.width * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: context.width * 0.34,
                height: context.height * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by complaint ID, title or citizen',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.height * 0.015),

          Row(
            children: [
              _filterButton(context, 'All', true),

              _filterButton(context, 'Pending', false),

              _filterButton(context, 'In Progress', false),

              _filterButton(context, 'Completed', false),

              const Spacer(),

              _dropdownButton(context, 'All Waste Types'),

              SizedBox(width: context.width * 0.01),

              _dropdownButton(context, 'All Wards'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterButton(BuildContext context, String text, bool selected) {
    return Padding(
      padding: EdgeInsets.only(right: context.width * 0.008),
      child: Container(
        height: context.height * 0.055,
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.012),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primaryColor : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: context.width * 0.010,
            color: selected ? Colors.white : Colors.grey.shade700,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _dropdownButton(BuildContext context, String text) {
    return Container(
      width: context.width * 0.14,
      height: context.height * 0.055,
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: context.width * 0.010,
              color: Colors.grey.shade700,
            ),
          ),

          const Spacer(),

          const Icon(Icons.keyboard_arrow_down, size: 20),
        ],
      ),
    );
  }

  Widget _complaintTable(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: context.height * 0.07,
          dataRowHeight: context.height * 0.08,

          columns: const [
            DataColumn(label: Text('COMPLAINT ID')),
            DataColumn(label: Text('PHOTO')),
            DataColumn(label: Text('COMPLAINT TITLE')),
            DataColumn(label: Text('CITIZEN')),
            DataColumn(label: Text('WASTE TYPE')),
            DataColumn(label: Text('WARD / LOCATION')),
            DataColumn(label: Text('SUBMITTED DATE')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('ACTION')),
          ],

          rows: [
            _complaintRow(
              context,
              'ECO-1042',
              'assets/household_waste.jpg',
              'Household Waste',
              'Rahul Sharma',
              'Household Waste',
              'Ward 07',
              '12 Mar 2026',
              'In Progress',
              Colors.blue,
            ),

            _complaintRow(
              context,
              'ECO-1038',
              'assets/construction_waste.jpg',
              'Construction Debris',
              'Amit Patil',
              'Construction Debris',
              'Ward 07',
              '08 Mar 2026',
              'Completed',
              Colors.green,
            ),

            _complaintRow(
              context,
              'ECO-1031',
              'assets/garden_waste.jpg',
              'Garden Waste',
              'Priya Shah',
              'Garden Waste',
              'Ward 04',
              '02 Mar 2026',
              'Completed',
              Colors.green,
            ),

            _complaintRow(
              context,
              'ECO-1025',
              'assets/plastic_waste.jpg',
              'Plastic Waste',
              'Sameer Khan',
              'Plastic Waste',
              'Ward 04',
              '27 Feb 2026',
              'Pending',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  DataRow _complaintRow(
    BuildContext context,
    String id,
    String image,
    String title,
    String citizen,
    String wasteType,
    String location,
    String date,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.w600))),

        DataCell(
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: context.width * 0.035,
              height: context.width * 0.035,
              fit: BoxFit.cover,
            ),
          ),
        ),

        DataCell(Text(title)),

        DataCell(Text(citizen)),

        DataCell(Text(wasteType)),

        DataCell(Text(location)),

        DataCell(Text(date)),

        DataCell(
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.008,
              vertical: context.height * 0.006,
            ),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: context.width * 0.009,
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        DataCell(
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintDetailScreen(
                    complaintId: id,
                    citizen: citizen,
                    wasteType: wasteType,
                    location: location,
                    date: date,
                    status: status,
                  ),
                ),
              );
            },
            child: Text(
              'View',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
