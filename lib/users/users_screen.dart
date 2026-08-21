import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:ecotrack_admin_panel/users/user_detail_screen.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        context.width * 0.018,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Users',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: context.height * 0.008,
          ),

          Text(
            'Manage registered EcoTrack citizens.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),

          SizedBox(
            height: context.height * 0.025,
          ),

          _searchBox(context),

          SizedBox(
            height: context.height * 0.025,
          ),

          _usersTable(context),
        ],
      ),
    );
  }

  Widget _searchBox(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        context.width * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth < 450
                ? constraints.maxWidth
                : 450,
            height: 48,
            child: TextField(
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Search user',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _usersTable(
    BuildContext context,
  ) {
    double tableWidth = 1100;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: tableWidth,
          child: Column(
            children: [
              _tableHeader(
                context,
                tableWidth,
              ),

              _userRow(
                context,
                tableWidth,
                'Rahul Sharma',
                'rahul.sharma@gmail.com',
                '+9198220 41576',
                '12 complaints',
                '12 Mar 2026',
                'Active',
              ),

              _userRow(
                context,
                tableWidth,
                'Amit Patil',
                'amit.patil@gmail.com',
                '+9198765 43210',
                '8 complaints',
                '08 Mar 2026',
                'Active',
              ),

              _userRow(
                context,
                tableWidth,
                'Priya Shah',
                'priya.shah@gmail.com',
                '+9199887 66554',
                '6 complaints',
                '02 Mar 2026',
                'Active',
              ),

              _userRow(
                context,
                tableWidth,
                'Sameer Khan',
                'sameer.khan@gmail.com',
                '+9197654 32109',
                '5 complaints',
                '27 Feb 2026',
                'Active',
              ),

              _userRow(
                context,
                tableWidth,
                'Neha Joshi',
                'neha.joshi@gmail.com',
                '+9196543 21098',
                '4 complaints',
                '21 Feb 2026',
                'Active',
              ),

              _userRow(
                context,
                tableWidth,
                'Vikas Deshmukh',
                'vikas.deshmukh@gmail.com',
                '+9195432 10987',
                '3 complaints',
                '16 Feb 2026',
                'Inactive',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeader(
    BuildContext context,
    double tableWidth,
  ) {
    return Container(
      height: 40,
      color: const Color(0xFFF8FAFA),
      child: Row(
        children: [
          _headerCell(
            context,
            'NAME',
            tableWidth * 0.14,
          ),

          _headerCell(
            context,
            'EMAIL',
            tableWidth * 0.22,
          ),

          _headerCell(
            context,
            'MOBILE',
            tableWidth * 0.15,
          ),

          _headerCell(
            context,
            'TOTAL COMPLAINTS',
            tableWidth * 0.15,
          ),

          _headerCell(
            context,
            'JOINED DATE',
            tableWidth * 0.12,
          ),

          _headerCell(
            context,
            'STATUS',
            tableWidth * 0.10,
          ),

          _headerCell(
            context,
            'ACTION',
            tableWidth * 0.08,
          ),
        ],
      ),
    );
  }

  Widget _headerCell(
    BuildContext context,
    String text,
    double width,
  ) {
    return SizedBox(
      width: width,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _userRow(
    BuildContext context,
    double tableWidth,
    String name,
    String email,
    String mobile,
    String complaints,
    String joinedDate,
    String status,
  ) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          _dataCell(
            context,
            name,
            tableWidth * 0.14,
            bold: true,
          ),

          _dataCell(
            context,
            email,
            tableWidth * 0.22,
          ),

          _dataCell(
            context,
            mobile,
            tableWidth * 0.15,
          ),

          _dataCell(
            context,
            complaints,
            tableWidth * 0.15,
          ),

          _dataCell(
            context,
            joinedDate,
            tableWidth * 0.12,
          ),

          SizedBox(
            width: tableWidth * 0.10,
            child: Align(
              alignment:
                  Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: status == 'Active'
                      ? const Color(
                          0xFFDDF5E2,
                        )
                      : const Color(
                          0xFFF1F3F3,
                        ),
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: status == 'Active'
                        ? Colors.green.shade700
                        : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            width: tableWidth * 0.08,
            child: Align(
              alignment:
                  Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserDetailScreen(),
                    ),
                  );
                },
                style:
                    OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Colors.grey.shade800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataCell(
    BuildContext context,
    String text,
    double width, {
    bool bold = false,
  }) {
    return SizedBox(
      width: width,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: bold
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}