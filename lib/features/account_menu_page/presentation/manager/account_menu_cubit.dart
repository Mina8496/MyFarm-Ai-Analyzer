import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_menu_state.dart';

class AccountMenuCubit extends Cubit<AccountMenuPageState> {
  AccountMenuCubit() : super(FeatureInitial());

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
