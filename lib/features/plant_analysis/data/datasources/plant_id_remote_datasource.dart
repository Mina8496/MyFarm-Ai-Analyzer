import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myfarm/AppConfig.dart';
import 'package:myfarm/features/plant_analysis/data/knowledge/DiseaseKnowledge.dart';
import 'package:myfarm/features/plant_analysis/data/model/plant_analysis_model.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/Disease_Model.dart';

class PlantIdRemoteDataSource {
  static const _apiKey = 'v9ckNDdkBWYAYWpKjaXBMQRkPROZwrMPUSxlucOPIOIjAJtSdK';
  static const _baseUrl = 'https://api.plant.id/v3/identification';

  final lang = AppConfig.lang;

  Future<PlantAnalysisModel> analyzeImage(File imageFile) async {
    print('🟡 DataSource started');

    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    /// 1️⃣ CREATE IDENTIFICATION
    final uri = Uri.parse(
      _baseUrl,
    ).replace(queryParameters: {'language': lang});

    final createResponse = await http
        .post(
          uri,
          headers: {'Api-Key': _apiKey, 'Content-Type': 'application/json'},
          body: jsonEncode({
            "images": [base64Image],

            // تصنيف النبات
            "classification_level": "species",

            // تشخيص صحي كامل
            "health": "all",

            // تشخيص أمراض كامل
            "disease_model": "full",
          }),
        )
        .timeout(const Duration(seconds: 60));

    print('📥 CREATE status: ${createResponse.statusCode}');
    print('📦 CREATE body: ${createResponse.body}');

    if (createResponse.statusCode != 201) {
      throw Exception('Create identification failed');
    }

    final createJson = jsonDecode(createResponse.body);
    final accessToken = createJson['access_token'];

    /// 2️⃣ GET IDENTIFICATION RESULT
    final resultResponse = await http.get(
      Uri.parse(
        '$_baseUrl/$accessToken',
      ).replace(queryParameters: {'language': lang}),
      headers: {'Api-Key': _apiKey},
    );

    print('📥 RESULT status: ${resultResponse.statusCode}');
    print('📦 RESULT body: ${resultResponse.body}');

    if (resultResponse.statusCode != 200) {
      throw Exception('Fetch result failed');
    }

    return PlantAnalysisModel.fromJson(jsonDecode(resultResponse.body));
  }

  Future<DiseaseModel> getDiseaseDetails(DiseaseModel disease) async {
    // لو التفاصيل موجودة خلاص
    if (disease.description != null && disease.description!.isNotEmpty) {
      return disease;
    }

    // final lang = AppConfig.lang;

    final uri = Uri.parse(
      'https://api.plant.id/v3/diseases/${disease.entityId}',
    ).replace(queryParameters: {'language': lang});

    try {
      final response = await http.get(uri, headers: {'Api-Key': _apiKey});

      if (response.statusCode != 200) {
        return _fallbackLocalDisease(disease);
      }

      final json = jsonDecode(response.body);
      final details = json['details'];
      final treatment = details?['treatment'];

      return disease.copyWith(
        description: details?['description'],
        causes: List<String>.from(details?['common_names'] ?? []),
        biologicalTreatment: treatment?['biological'] != null
            ? [treatment['biological']]
            : [],
        chemicalTreatment: treatment?['chemical'] != null
            ? [treatment['chemical']]
            : [],
        prevention: treatment?['prevention'] != null
            ? [treatment['prevention']]
            : [],
      );
    } catch (_) {
      return _fallbackLocalDisease(disease);
    }
  }

  DiseaseModel _fallbackLocalDisease(DiseaseModel disease) {
    final local = DiseaseKnowledge.data[disease.name];
    if (local == null) return disease;
    print('ENTITY ID => ${disease.entityId}');
    print('NAME => ${disease.name}');

    return disease.copyWith(
      // name: data['name'], // عربي
      description: local['description'],
      symptoms: List<String>.from(local['symptoms']),
      causes: List<String>.from(local['causes']),
      chemicalTreatment: List<String>.from(local['chemicalTreatment']),
      biologicalTreatment: List<String>.from(local['biologicalTreatment']),
      prevention: List<String>.from(local['prevention']),
    );
  }
}
