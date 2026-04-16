import 'package:dio/dio.dart';
import 'package:myfarm/features/PlantTip/domin/model/plantTip_model.dart';

class PlantTipsService {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000/api"));

  Future<List<PlantTipModel>> getTips({String? category}) async {
    final response = await dio.get(
      '/tips',
      queryParameters: {if (category != null) "category": category},
    );

    return (response.data as List)
        .map((e) => PlantTipModel.fromJson(e))
        .toList();
  }
}
