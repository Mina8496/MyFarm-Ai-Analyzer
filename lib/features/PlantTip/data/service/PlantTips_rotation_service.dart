import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

class PlantTipsRotationService {
  int index = 0;

  List<PlantTip> getNext(List<PlantTip> tips) {
    if (tips.length <= 2) return tips;

    final start = index;
    final end = (index + 2) % tips.length;

    List<PlantTip> result;

    if (end > start) {
      result = tips.sublist(start, end);
    } else {
      result = [
        ...tips.sublist(start),
        ...tips.sublist(0, end),
      ];
    }

    index = (index + 2) % tips.length;
    return result;
  }
}