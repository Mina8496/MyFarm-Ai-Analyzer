enum UserRole { farmer, engineer, supervisor, owner }

extension UserRoleExtension on UserRole {
  String get arabicName {
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

  String get hint {
    switch (this) {
      case UserRole.farmer:
        return 'ريّ، حصاد، تسميد';
      case UserRole.engineer:
        return 'تحليل التربة، جدولة';
      case UserRole.supervisor:
        return 'متابعة الفريق';
      case UserRole.owner:
        return 'إدارة كاملة';
    }
  }

  /// هل يملك صلاحية الحذف؟
  bool get canDelete {
    return this == UserRole.supervisor || this == UserRole.owner;
  }

  /// هل يملك صلاحية التعديل؟
  bool get canEdit {
    return this != UserRole.farmer;
  }
}
