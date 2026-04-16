import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

class PlantTipModel extends PlantTip {
  PlantTipModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
  });

  factory PlantTipModel.fromJson(Map<String, dynamic> json, String id) {
    return PlantTipModel(
      id: id,
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'imageUrl': imageUrl};
  }
}
