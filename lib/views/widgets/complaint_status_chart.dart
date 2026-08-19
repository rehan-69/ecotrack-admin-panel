import 'package:ecotrack_admin_panel/constants/app_color.dart';
import 'package:ecotrack_admin_panel/constants/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ComplaintStatusChart extends StatelessWidget {
  const ComplaintStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.width * 0.018),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complaint Status Overview',
            style: TextStyle(
              fontSize: context.width * 0.013,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),

          SizedBox(height: context.height * 0.008),

          Text(
            'Distribution of complaints by current status.',
            style: TextStyle(
              fontSize: context.width * 0.010,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: context.height * 0.025),

          SizedBox(
            height: context.height * 0.32,
            child: BarChart(
              BarChartData(
                maxY: 80,
                minY: 0,

                alignment: BarChartAlignment.spaceAround,

                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem:
                        (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toInt().toString(),
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    );
                  },
                ),

                borderData: FlBorderData(
                  show: false,
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: context.width * 0.025,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: context.width * 0.009,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        String title = '';

                        if (value == 0) {
                          title = 'Pending';
                        } else if (value == 1) {
                          title = 'In Progress';
                        } else if (value == 2) {
                          title = 'Completed';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: context.width * 0.009,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                barGroups: [
                  _barGroup(
                    0,
                    24,
                    Colors.orange,
                  ),

                  _barGroup(
                    1,
                    31,
                    Colors.blue,
                  ),

                  _barGroup(
                    2,
                    73,
                    AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(
    int x,
    double value,
    Color color,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 45,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ],
    );
  }
}