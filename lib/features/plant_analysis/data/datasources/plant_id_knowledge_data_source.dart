import 'dart:convert';

import 'package:http/http.dart' as http;

class PlantIdKnowledgeDataSource {
  static final _apiKey = "J58kPkph5mKA8TJqfsy3EKZCNWtz6Nj9QSqJ6cRiFu9zoYR2dW";
  static const _baseUrl = 'https://api.plant.id/v3/entities';

  Future<Map<String, dynamic>> fetchDiseaseDetails(String entityId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$entityId'),
      headers: {'Api-Key': _apiKey},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch disease details');
    }

    return jsonDecode(response.body);
  }
}
