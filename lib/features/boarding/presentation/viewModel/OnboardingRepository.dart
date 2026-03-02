import 'package:myfarm/features/boarding/presentation/views/widgets/PageView_item.dart';

abstract class OnboardingRepository {
  Future<List<PageViewItem>> fetchOnboardingItems(String lang);
}
