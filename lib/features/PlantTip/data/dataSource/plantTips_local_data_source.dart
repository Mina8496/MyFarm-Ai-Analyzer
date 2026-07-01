import 'package:hive/hive.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';

class PlantTipsLocalDataSource {
  static const String _boxName = 'plantTipsBox';

  static Future<void> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<PlantTipModel>(_boxName);
    }
  }

  Box<PlantTipModel> get _box => Hive.box<PlantTipModel>(_boxName);

  Future<void> cachePlantTips(List<PlantTipModel> tips) async {
    final newIds = tips.map((t) => t.id).toSet();
    final oldKeys = _box.keys.where((k) => !newIds.contains(k)).toList();
    if (oldKeys.isNotEmpty) {
      await _box.deleteAll(oldKeys);
    }
    await _box.putAll({for (var tip in tips) tip.id: tip});
  }

  List<PlantTipModel> getCachedPlantTips() => _box.values.toList();

  bool get isEmpty => _box.isEmpty;
}
