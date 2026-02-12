class PlantNameArabicMapper {
  static const Map<String, String> _map = {
    'solanum lycopersicum': 'طماطم',
    'solanum tuberosum': 'بطاطس',
    'capsicum annuum': 'فلفل',
    'mangifera indica': 'مانجو',
    'citrus sinensis': 'برتقال',
  };

  static String translate(String scientificName) {
    final key = scientificName.toLowerCase().trim();
    return _map[key] ?? scientificName; // fallback EN لو مش موجود
  }
}
