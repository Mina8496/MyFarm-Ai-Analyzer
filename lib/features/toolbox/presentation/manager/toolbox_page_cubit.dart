import 'package:flutter_bloc/flutter_bloc.dart';

part 'toolbox_state.dart';

class ToolboxPageCubit extends Cubit<ToolboxPageState> {
  ToolboxPageCubit() : super(ToolboxPageInitial());

  Future<void> init() async {
    emit(ToolboxPageLoading());
    try {
      // TODO: استدعي الـ use case أو الـ repository هنا
      emit(ToolboxPageLoaded(data: null));
    } catch (e) {
      emit(ToolboxPageError(message: e.toString()));
    }
  }
}
