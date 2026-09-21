import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/entities/Disease_Model.dart';

class DiseaseBarChart extends StatelessWidget {
  final List<DiseaseModel> diseases;
  const DiseaseBarChart(this.diseases, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Classification Result'.tr,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 220.h,
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index >= diseases.length) return const SizedBox();
                          return Padding(
                            padding: EdgeInsets.only(top: 8.dg),
                            child: Text(
                              diseases[index].name.tr,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(diseases.length, (index) {
                    final d = diseases[index];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: d.confidence * 100.h,
                          width: 22.w,
                          borderRadius: BorderRadius.circular(6.r),
                          color: index == 0
                              ? Colors.orange
                              : Colors.grey.shade400,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
