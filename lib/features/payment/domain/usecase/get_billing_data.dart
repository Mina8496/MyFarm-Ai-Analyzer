import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';

/// يجيب بيانات المستخدم الحالي من Firestore (users/{uid})
/// ويحوّلها لـ BillingData جاهزة تتبعت لـ Paymob.
///
/// لو المستخدم مش مسجل دخول، أو الداتا ناقصة، بيرجع
/// fallback آمن بدل ما يرمي exception ويوقف تدفق الدفع.
class GetBillingDataUseCase {
  final fb.FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const GetBillingDataUseCase(this.auth, this.firestore);

  Future<BillingData> call() async {
    final user = auth.currentUser;
    if (user == null) {
      return _fallback();
    }

    try {
      final doc = await firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        return _fallback(email: user.email);
      }

      final data = doc.data()!;
      final fullName = (data['name'] as String?)?.trim() ?? '';
      final nameParts = fullName.isEmpty ? <String>[] : fullName.split(RegExp(r'\s+'));

      final firstName = nameParts.isNotEmpty ? nameParts.first : 'عميل';
      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : 'تطبيق'; // Paymob محتاج last name، فبنحط قيمة افتراضية لو مفيش

      return BillingData(
        firstName: firstName,
        lastName: lastName,
        email: (data['email'] as String?)?.trim().isNotEmpty == true
            ? data['email'] as String
            : (user.email ?? 'noemail@myfarm.app'),
        phone: (data['phone'] as String?)?.trim().isNotEmpty == true
            ? data['phone'] as String
            : '01000000000',
        // مفيش city/address في الـ UserModel الحالي، فبنحط قيم افتراضية
        // (لو ضفتهم بعدين في الـ user doc هنا أول مكان تقراهم منه)
        city: (data['city'] as String?)?.trim().isNotEmpty == true
            ? data['city'] as String
            : 'القاهرة',
        country: 'EG',
      );
    } catch (_) {
      // أي خطأ في القراءة (صلاحيات، شبكة...) منوقفش تدفق الدفع بسببه
      return _fallback(email: user.email);
    }
  }

  BillingData _fallback({String? email}) {
    return BillingData(
      firstName: 'عميل',
      lastName: 'تطبيق',
      email: email ?? 'noemail@myfarm.app',
      city: 'القاهرة',
      country: 'EG',
      phone: '01000000000',
    );
  }
}