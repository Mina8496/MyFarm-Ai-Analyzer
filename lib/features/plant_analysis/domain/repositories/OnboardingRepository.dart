import 'package:myfarm/features/plant_analysis/domain/entities/onboarding_item.dart';

abstract class OnboardingRepository {
  Future<List<OnboardingItem>> fetchOnboardingItems(String lang);
}
