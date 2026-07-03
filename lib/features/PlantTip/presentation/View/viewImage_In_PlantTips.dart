import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

class PlantTipsImageCacheManager extends CacheManager {
  PlantTipsImageCacheManager._()
    : super(
        Config(
          'plantTipsCache',
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 100,
          repo: JsonCacheInfoRepository(databaseName: 'plantTipsCache'),
          fileService: HttpFileService(),
        ),
      );

  static final PlantTipsImageCacheManager _instance =
      PlantTipsImageCacheManager._();

  factory PlantTipsImageCacheManager() => _instance;
}

class ViewImageInPlantTips extends StatelessWidget {
  const ViewImageInPlantTips({super.key, required this.tip});

  final PlantTip tip;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: CachedNetworkImage(
        key: ValueKey(tip.imageUrl),
        imageUrl: tip.imageUrl,
        cacheManager: PlantTipsImageCacheManager(),
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        useOldImageOnUrlChange: true,
        fadeOutDuration: Duration.zero,
        fadeInDuration: const Duration(milliseconds: 250),

        // في حالة الخطأ (صورة مش موجودة / رابط غلط)
        errorWidget: (context, error, url) {
          return Container(
            height: 180,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Image.asset(
              "assets/boarding/third.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
