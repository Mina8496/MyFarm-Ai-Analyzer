class DiseaseKeyMapper {
  static const Map<String, String> _map = {
    // ===== VIRUS =====
    'tobamovirus': 'tobamovirus',
    'tobacco mosaic virus': 'tobamovirus',

    // ===== FUNGI =====
    'fungi': 'fungal_disease',
    'fungal disease': 'fungal_disease',

    // ===== TOMATO =====
    'early blight': 'tomato_early_blight',
    'late blight': 'tomato_late_blight',

    // ===== POTATO =====
    'potato early blight': 'potato_early_blight',

    // ===== PEPPER =====
    'bacterial spot': 'pepper_bacterial_spot',

    // ===== MANGO =====
    'anthracnose': 'mango_anthracnose',
    'powdery mildew': 'mango_powdery_mildew',

    // ===== CITRUS =====
    'citrus canker': 'citrus_canker',
    'greening': 'citrus_greening',

    // ===== NUTRITION =====
    'nutrient deficiency': 'nutrient_deficiency',
  };

  static String? map(String plantIdName) {
    final key = plantIdName.toLowerCase().trim();
    return _map[key];
  }
}
