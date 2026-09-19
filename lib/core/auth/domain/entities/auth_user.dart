class AuthUser {
  final String id;
  final String email;
  final String? displayName;

  const AuthUser({required this.id, required this.email, this.displayName});

  /// وإلا نص افتراضي. مكانها هنا عشان أي حد يستخدم AuthUser ياخد نفس
  String get displayNameOrFallback {
    if (displayName != null && displayName!.trim().isNotEmpty) {
      return displayName!;
    }
    if (email.trim().isNotEmpty) return email;
    return 'مستخدم';
  }
}
