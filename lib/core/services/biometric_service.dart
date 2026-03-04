import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final bool canCheck = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();

      if (!canCheck || !isSupported) return false;

      return await _auth.authenticate(
        localizedReason: 'تسجيل الدخول بالبصمة',
        biometricOnly: true,
      );
    } catch (_) {
      return false;
    }
  }
}
