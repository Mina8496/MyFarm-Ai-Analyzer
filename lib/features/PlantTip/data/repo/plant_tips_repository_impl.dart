import 'package:myfarm/features/PlantTip/data/dataSource/plant_tips_remote_data_source.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plant_tips_local_data_source.dart';
import 'package:myfarm/features/PlantTip/data/model/plant_tip_model.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/plant_tip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/plant_tips_repository.dart';

class PlantTipsRepositoryImpl implements PlantTipsRepository {
  final PlantTipsRemoteDataSource remote;
  final PlantTipsLocalDataSource local;

  PlantTipsRepositoryImpl({required this.remote, required this.local});

  @override
  Stream<List<PlantTip>> getPlantTips() async* {
    if (!local.isEmpty) {
      yield local.getCachedPlantTips().map((m) => m.toEntity()).toList();
    }

    await for (final tips in remote.getPlantTips()) {
      final models = tips
          .map(
            (t) => PlantTipModel(
              id: t.id,
              title: t.title,
              description: t.description,
              imageUrl: t.imageUrl,
            ),
          )
          .toList();

      await local.cachePlantTips(models);

      yield models.map((m) => m.toEntity()).toList();
    }
  }
}
