class PlantHistoryEntity {
  final String plantName;
  final String diseaseName;
  final int severity;
  final DateTime date;

  PlantHistoryEntity({
    required this.plantName,
    required this.diseaseName,
    required this.severity,
    required this.date,
  });
}
