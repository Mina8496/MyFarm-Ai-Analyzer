import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfarm/core/errors/failure.dart';

class FirebaseExceptionMapper {
  static Failure map(Object error) {
    if (error is FirebaseAuthException) {
      return _mapAuthException(error);
    }

    if (error is FirebaseException) {
      return _mapFirestoreException(error);
    }

    return UnknownFailure(error.toString());
  }

  // ─── FirebaseAuth Errors ─────────────────────────────
  static Failure _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      // ── Login ──
      case 'user-not-found':
        return ServerFailure('البريد الإلكتروني غير مسجل');
      case 'wrong-password':
        return ServerFailure('كلمة المرور غير صحيحة');
      case 'invalid-email':
        return ServerFailure('البريد الإلكتروني غير صالح');
      case 'user-disabled':
        return ServerFailure('تم تعطيل هذا الحساب');
      case 'too-many-requests':
        return ServerFailure('محاولات كثيرة، حاول لاحقاً');
      case 'invalid-credential':
        return ServerFailure('البيانات غير صحيحة');

      // ── Signup ──
      case 'email-already-in-use':
        return ServerFailure('البريد الإلكتروني مستخدم بالفعل');
      case 'weak-password':
        return ServerFailure('كلمة المرور ضعيفة جداً');
      case 'operation-not-allowed':
        return ServerFailure('هذه العملية غير مسموح بها');

      // ── Network ──
      case 'network-request-failed':
        return NetworkFailure('تحقق من اتصالك بالإنترنت');

      // ── Session ──
      case 'requires-recent-login':
        return ServerFailure('يجب تسجيل الدخول مرة أخرى');
      case 'user-token-expired':
        return ServerFailure('انتهت الجلسة، سجل دخولك مجدداً');

      default:
        return ServerFailure(e.message ?? 'حدث خطأ غير متوقع');
    }
  }

  // ─── Firestore Errors ────────────────────────────────
  static Failure _mapFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return ServerFailure('ليس لديك صلاحية للوصول');
      case 'not-found':
        return ServerFailure('البيانات غير موجودة');
      case 'already-exists':
        return ServerFailure('البيانات موجودة بالفعل');
      case 'unavailable':
        return NetworkFailure('الخدمة غير متاحة حالياً');
      case 'deadline-exceeded':
        return NetworkFailure('انتهت مهلة الاتصال');
      case 'cancelled':
        return ServerFailure('تم إلغاء العملية');

      default:
        return ServerFailure(e.message ?? 'حدث خطأ في قاعدة البيانات');
    }
  }
}
