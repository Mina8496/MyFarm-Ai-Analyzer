class PlantTipModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String category;
  final String plantType;

  PlantTipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.category,
    required this.plantType,
  });

  factory PlantTipModel.fromJson(Map<String, dynamic> json) {
    return PlantTipModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      category: json['category'],
      plantType: json['plantType'],
    );
  }
}