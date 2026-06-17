enum UserRole {
  farmer,
  engineer,
  supervisor,
  owner;

  String get displayName {
    switch (this) {
      case UserRole.farmer:
        return 'مزارع';
      case UserRole.engineer:
        return 'مهندس زراعي';
      case UserRole.supervisor:
        return 'مشرف';
      case UserRole.owner:
        return 'مالك مزرعة';
    }
  }

  String get emoji {
    switch (this) {
      case UserRole.farmer:
        return '🌾';
      case UserRole.engineer:
        return '🔬';
      case UserRole.supervisor:
        return '📋';
      case UserRole.owner:
        return '🏡';
    }
  }

  /// ما يقدر يعمله كل دور
  bool get canCreate => true; // الكل يقدر يضيف مهمة

  bool get canEdit {
    return this == UserRole.engineer ||
        this == UserRole.supervisor ||
        this == UserRole.owner;
  }

  bool get canDelete {
    return this == UserRole.supervisor || this == UserRole.owner;
  }

  String get roleDescription {
    switch (this) {
      case UserRole.farmer:
        return 'يُضيف ويُكمل المهام اليومية';
      case UserRole.engineer:
        return 'يُضيف ويُعدّل المهام التقنية';
      case UserRole.supervisor:
        return 'يُشرف على جميع المهام ويحذف';
      case UserRole.owner:
        return 'صلاحيات كاملة على المزرعة';
    }
  }
}