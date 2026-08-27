import 'dart:async';

import 'package:get/get.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/close_ambient_screen.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/get_ambient_settings.dart';

import '../../domain/entities/ambient_settings.dart';


class AmbientController extends GetxController {
  final GetAmbientSettings getAmbientSettings;
  final CloseAmbientScreen closeAmbientScreen;

  AmbientController({
    required this.getAmbientSettings,
    required this.closeAmbientScreen,
  });

  final Rx<DateTime> now = DateTime.now().obs;

  final Rx<AmbientSettings> settings =
      const AmbientSettings().obs;

  Timer? _clockTimer;
  Timer? _timeoutTimer;

  @override
  void onInit() {
    super.onInit();

    _startClock();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final result = await getAmbientSettings();

    settings.value = result;

    _startTimeout();
  }

  void _startClock() {
    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        now.value = DateTime.now();
      },
    );
  }

  void _startTimeout() {
    _timeoutTimer?.cancel();

    final timeout = settings.value.timeout;

    if (timeout <= 0) {
      return;
    }

    _timeoutTimer = Timer(
      Duration(seconds: timeout),
      close,
    );
  }

  Future<void> close() async {
    await closeAmbientScreen();
  }

  String get time {
    final value = now.value;

    return '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
  }

  String get date {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final value = now.value;

    return '${days[value.weekday - 1]}, '
        '${value.day} ${months[value.month - 1]} '
        '${value.year}';
  }

  @override
  void onClose() {
    _clockTimer?.cancel();
    _timeoutTimer?.cancel();

    super.onClose();
  }
}