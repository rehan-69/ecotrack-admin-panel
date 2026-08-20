import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:flutter/material.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final String complaintId;
  final String image;
  final String title;
  final String citizen;
  final String wasteType;
  final String location;
  final String date;
  final String status;

  const ComplaintDetailScreen({
    super.key,
    required this.complaintId,
    required this.image,
    required this.title,
    required this.citizen,
    required this.wasteType,
    required this.location,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          context.width * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),

                SizedBox(
                  width: context.width * 0.005,
                ),

                Text(
                  'Complaint Details',
                  style: TextStyle(
                    fontSize: context.width * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: context.height * 0.025,
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                context.width * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.04,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complaintId,
                    style: TextStyle(
                      fontSize: context.width * 0.015,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.008,
                  ),

                  Text(
                    title,
                    style: TextStyle(
                      fontSize: context.width * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.02,
                  ),

                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),
                        child: Image.asset(
                          image,
                          width: context.width * 0.22,
                          height: context.height * 0.30,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(
                        width: context.width * 0.025,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            _detailItem(
                              context,
                              'Citizen',
                              citizen,
                            ),

                            _detailItem(
                              context,
                              'Waste Type',
                              wasteType,
                            ),

                            _detailItem(
                              context,
                              'Ward / Location',
                              location,
                            ),

                            _detailItem(
                              context,
                              'Submitted Date',
                              date,
                            ),

                            _detailItem(
                              context,
                              'Status',
                              status,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: context.height * 0.025,
                  ),

                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: context.width * 0.013,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.008,
                  ),

                  Text(
                    'Waste has been reported at this '
                    'location. Please review the complaint '
                    'and take appropriate action.',
                    style: TextStyle(
                      fontSize: context.width * 0.011,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.025,
                  ),

                  Text(
                    'Update Status',
                    style: TextStyle(
                      fontSize: context.width * 0.013,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: context.height * 0.01,
                  ),

                  Container(
                    width: 280,
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          status,
                          style: TextStyle(
                            fontSize:
                                context.width * 0.010,
                          ),
                        ),

                        const Spacer(),

                        const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(
    BuildContext context,
    String title,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.height * 0.018,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.width * 0.009,
              color: Colors.grey,
            ),
          ),

          SizedBox(
            height: context.height * 0.004,
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: context.width * 0.012,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}