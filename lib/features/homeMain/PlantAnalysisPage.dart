import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/plant_analysis_controller.dart';
import 'package:myfarm/features/plant_analysis/Presentation/widgets/_ImagePickerCard.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/plant_analysis_entity.dart';

class PlantAnalysisPage extends GetView<PlantAnalysisController> {
  const PlantAnalysisPage({super.key});

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text('Capture'.tr),
              onTap: () async {
                Navigator.pop(context);
                final file = await _getImage(ImageSource.camera);
                if (file != null) controller.analyzeImage(file);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('Pick'.tr),
              onTap: () async {
                Navigator.pop(context);
                final file = await _getImage(ImageSource.gallery);
                if (file != null) controller.analyzeImage(file);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    return picked != null ? File(picked.path) : null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF81C784), Color(0xFF388E3C)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Color(0xFF388E3C),
          appBar: AppBar(
            backgroundColor: const Color(0xFF2E7D32),
            elevation: 0,
            title: Row(
              children: [
                Icon(Icons.eco, size: 22),
                SizedBox(width: 8.w),
                Text('plant_analysis'.tr),
              ],
            ),
          ),

          body: LayoutBuilder(
            builder: (context, constraints) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF81C784), Color(0xFF388E3C)],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Obx(() {
                  final image = controller.imageFile.value;

                  if (controller.loading.value) {
                    return const _LoadingState();
                  }

                  if (controller.error.isNotEmpty) {
                    return _ErrorState(controller.error.value);
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// IMAGE PICKER (ALWAYS VISIBLE)
                        ImagePickerCard(
                          imageFile: image,
                          onPick: () => _pickImage(context),
                        ),

                        // SizedBox(height: 167.h),

                        /// RESULT
                        if (controller.result.value != null)
                          _ResultCard(controller.result.value!),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 16.h),

        Text('analyzing'.tr),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ResultCard extends GetView<PlantAnalysisController> {
  final PlantAnalysisEntity result;
  const _ResultCard(this.result);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// STATUS + CONFIDENCE
          Row(
            children: [
              ElevatedButton(
                onPressed: controller.speakResult,
                child: const Text('🔊 اسمع النتيجة'),
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: controller.stopSpeaking,
              ),
            ],
          ),
          Row(
            children: [
              _StatusBadge(isHealthy: result.isHealthy),
              const Spacer(),
              Text(
                '${(result.confidence * 100).toStringAsFixed(1)}%',
                // style: GoogleFonts.poppins(
                //   fontWeight: FontWeight.w600,
                //   color: Colors.white,
                // ),
              ),
            ],
          ),

          // SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: _InfoCard(title: result.plantName),
          ),

          /// DESCRIPTION
          // _InfoCard(
          //   title: 'Analysis_Summary'.tr,
          //   child: Text(
          //     result.isHealthy
          //         ? 'The_leaf_appears_healthy'.tr
          //         : 'Signs_of_disease'.tr,
          //     style: GoogleFonts.poppins(color: Colors.grey.shade700),
          //   ),
          // ),
          ////////////////////////////////////////////////////////// RELATED IMAGES //////////////////////////
          // const SizedBox(height: 16),
          /// RELATED IMAGES
          // _RelatedImages(),
          // SizedBox(height: 10.h),

          /// ANALYSIS DETAILS
          // _InfoCard(
          //   title: result.plantName,
          //   child: DiseaseBarChart(result.diseases),
          // ),

          // SizedBox(height: 16.h),

          /// DISEASE LIST
          if (result.diseases.isNotEmpty) ...[
            // Text(
            //   'Detected_Diseases'.tr,
            //   style: GoogleFonts.poppins(
            //     fontSize: 18.sp,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            SizedBox(height: 8.h),
            ...result.diseases.map((disease) => _DiseaseCard(disease)),
          ],

          /// FOLLOW UP QUESTION
          // if (result.followUpQuestion != null &&
          //     !controller.followUpAnswered.value)
          //   _FollowUpCard(result),

          // SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isHealthy;
  const _StatusBadge({required this.isHealthy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 6.w),
      decoration: BoxDecoration(
        color: isHealthy ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        isHealthy ? 'Healthy'.tr : 'Injured'.tr,
        // style: GoogleFonts.poppins(
        //   fontWeight: FontWeight.w600,
        //   color: isHealthy ? Colors.green : Colors.red,
        // ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  // final Widget child;

  const _InfoCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              // style: GoogleFonts.poppins(
              //   fontWeight: FontWeight.w600,
              //   fontSize: 16.sp,
              // ),
            ),
            // SizedBox(height: 12.h),
            // child,
          ],
        ),
      ),
    );
  }
}

class _DiseaseCard extends StatelessWidget {
  final DiseaseModel disease;
  const _DiseaseCard(this.disease);

  @override
  Widget build(BuildContext context) {
    // final treatment = disease.treatment;

    return Card(
      color: Colors.grey.shade50,
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.w),
            //       decoration: BoxDecoration(
            //         color: severityColor(disease.severity).withOpacity(0.15),
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       child: Text(
            //         severityText(disease.severity),
            //         style: TextStyle(
            //           color: severityColor(disease.severity),
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            /// NAME
            // DiseaseKnowledge.get(disease.name),
            Text(
              disease.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),

            /// CONFIDENCE
            Text(
              '${'confidence'.tr}: ${(disease.confidence * 100).toStringAsFixed(1)}%',
              style: const TextStyle(color: Colors.green),
            ),

            SizedBox(height: 5.h),

            /// CHEMICAL
            /// ////////////////////////////////
            if (disease.severity >= 4)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'This_disease_is_severe'.tr,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            if (disease.chemicalTreatment.isNotEmpty)
              _TreatmentSection(
                'Chemical_Treatment'.tr,
                disease.chemicalTreatment,
                icon: Icons.science,
              ),
            // if (disease.biologicalTreatment.isNotEmpty)
            //   _TreatmentSection(
            //     'Biological_Treatment'.tr,
            //     disease.biologicalTreatment,
            //     icon: Icons.eco,
            //   ),

            // if (disease.prevention.isNotEmpty)
            //   _TreatmentSection(
            //     'Prevention_Tips'.tr,
            //     disease.prevention,
            //     icon: Icons.shield,
            //   ),

            // SizedBox(height: 8.h),

            /// CAUSES
            if (disease.causes.isNotEmpty)
              Text('${'causes:'.tr} ${disease.causes.join('، ')}'),

            /// SYMPTOMS
            if (disease.symptoms.isNotEmpty)
              Text('${'symptoms:'.tr} ${disease.symptoms.join('، ')}'),

            /// DESCRIPTION (SAFE)
            if (disease.description == null &&
                disease.causes.isEmpty &&
                disease.symptoms.isEmpty)
              Text(
                'Diagnosis_detected_with_high_confidence'.tr,
                style: TextStyle(color: Colors.grey),
              ),

            SizedBox(height: 12.h),

            // Text(DiseaseArabicMapper.translate(disease.name))

            // DiseaseVideosSection(context, disease.name),
          ],
        ),
      ),
    );
  }
}

class _TreatmentSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;

  const _TreatmentSection(this.title, this.items, {required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(icon, size: 18),
            SizedBox(width: 6.w),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 4.h),
        ...items.map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 12, top: 2),
            child: Text('• $e'),
          ),
        ),
      ],
    );
  }
}

// class _FollowUpCard extends GetView<PlantAnalysisController> {
//   final PlantAnalysisEntity result;
//   const _FollowUpCard(this.result);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.amber.shade50,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//       child: Padding(
//         padding: EdgeInsets.all(12.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               result.followUpQuestion!,
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//             SizedBox(height: 12.h),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       controller.answerFollowUp(true);
//                     },
//                     child: Text('Yes'.tr),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       controller.answerFollowUp(false);
//                     },
//                     child: Text('No'.tr),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
