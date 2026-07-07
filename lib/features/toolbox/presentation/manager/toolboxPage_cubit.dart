import 'package:flutter_bloc/flutter_bloc.dart';

part 'toolbox_state.dart';

class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit() : super(FeatureInitial());

  Future<void> init() async {
    emit(FeatureLoading());
    try {
      // TODO: استدعي الـ use case أو الـ repository هنا
      emit(FeatureLoaded(data: null));
    } catch (e) {
      emit(FeatureError(message: e.toString()));
    }
  }
}