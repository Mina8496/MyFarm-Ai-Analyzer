import 'package:hive/hive.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

part 'plantTip_model.g.dart';

@HiveType(typeId: 1)
class PlantTipModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  PlantTipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory PlantTipModel.fromJson(Map<String, dynamic> json, String id) {
    return PlantTipModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // تحويل لـ Entity للـ Domain Layer
  PlantTip toEntity() => PlantTip(
        id: id,
        title: title,
        description: description,
        imageUrl: imageUrl,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
      };
}