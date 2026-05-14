import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_page_state.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(FeatureInitial());

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
