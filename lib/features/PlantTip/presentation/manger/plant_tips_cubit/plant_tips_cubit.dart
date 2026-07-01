import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/PlantTip/data/service/PlantTips_rotation_service.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/domin/repo/PlantTipsRepository.dart';
import 'plant_tips_state.dart';

class PlantTipsCubit extends Cubit<PlantTipsState> {
  final PlantTipsRepository repository;
  final PlantTipsRotationService rotationService;

  List<PlantTip> _allTips = [];
  Timer? _timer;
  StreamSubscription? _sub;

  PlantTipsCubit(this.repository, this.rotationService)
    : super(PlantTipsInitial());

  void init() {
    if (_sub != null) return;
    emit(PlantTipsLoading());

    _sub = repository.getPlantTips().listen(
      (data) {
        _allTips = data;
        _startRotation();
      },
      onError: (e) {
        emit(PlantTipsError(message: _mapErrorToMessage(e)));
      },
    );
  }

  void _startRotation() {
    _timer?.cancel();

    if (_allTips.length <= 1) {
      emit(PlantTipsLoaded(visibleTips: _allTips));
      return;
    }

    _update();

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _update();
    });
  }

  String _mapErrorToMessage(dynamic error) {
    final errorString = error.toString();

    if (errorString.contains('SocketException') ||
        errorString.contains('Failed host lookup')) {
      return 'لا يوجد اتصال بالإنترنت';
    }

    return 'تعذر تحميل النصائح حالياً';
  }

  void _update() {
    final visible = rotationService.getNext(_allTips);
    emit(PlantTipsLoaded(visibleTips: visible));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _timer?.cancel();
    return super.close();
  }
}
