import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';

class OnboardingRepository {
  final FirebaseFirestore firestore;

  OnboardingRepository({required this.firestore});

  Future<List<OnboardingItem>> fetchOnboardingItems(String langCode) async {
    try {
      final snapshot = await firestore.collection('onboarding').doc(langCode).collection('items').get();
      return snapshot.docs.map((doc) {
        return OnboardingItem(
          image: doc['image'],
          titleKey: doc['title_key'],
          descKey: doc['desc_key'],
        );
      }).toList();
    } catch (_) {
      // لو مش موجود، نرجع نسخة افتراضية
      return [
        OnboardingItem(
          image: 'assets/onboarding1.png',
          titleKey: 'onboarding_title1',
          descKey: 'onboarding_desc1',
        ),
      ];
    }
  }
}
