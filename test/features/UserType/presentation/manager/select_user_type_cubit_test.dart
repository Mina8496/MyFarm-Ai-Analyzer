import 'package:flutter_test/flutter_test.dart';
import 'package:myfarm/features/UserType/presentation/manager/select_user_type_cubit.dart';
import 'package:myfarm/features/UserType/presentation/manager/select_user_type_state.dart';

void main() {
  late SelectUserTypeCubit cubit;

  setUp(() {
    cubit = SelectUserTypeCubit();
  });

  test('selectType emits selected state with the chosen type', () {
    cubit.selectType('farmer');

    expect(cubit.state, isA<SelectUserTypeSelected>());
    expect((cubit.state as SelectUserTypeSelected).type, 'farmer');
  });

  test('confirmSelection emits error when no type is selected', () async {
    await cubit.confirmSelection();

    expect(cubit.state, isA<SelectUserTypeError>());
  });
}
