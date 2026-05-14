import 'package:myfarm/features/PlantTip/data/dataSource/PlantTipsRemoteDataSource.dart';
import 'package:myfarm/features/PlantTip/data/dataSource/plantTips_local_data_source.dart';
import 'package:myfarm/features/PlantTip/data/model/plantTip_model.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';

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
