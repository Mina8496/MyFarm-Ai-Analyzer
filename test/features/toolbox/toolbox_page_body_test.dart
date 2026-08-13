import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfarm/features/toolbox/presentation/manager/toolboxPage_cubit.dart';
import 'package:myfarm/features/toolbox/presentation/view/toolbox_page_body.dart';

void main() {
  testWidgets('shows toolbox tools cards', (tester) async {
    final cubit = ToolboxPageCubit();
    cubit.emit(ToolboxPageLoaded(data: null));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const Scaffold(body: ToolboxPageBody()),
        ),
      ),
    );

    expect(find.text('الأدوات'), findsOneWidget);
    expect(find.text('المنبه'), findsOneWidget);
    expect(find.text('الموسيقى'), findsOneWidget);
    expect(find.text('البوصلة'), findsOneWidget);
  });
}
