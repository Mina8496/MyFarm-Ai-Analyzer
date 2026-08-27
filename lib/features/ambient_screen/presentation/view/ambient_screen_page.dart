import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/ambient_screen_service.dart';
import '../../data/ambient_settings_service.dart';

class AmbientScreenPage extends StatefulWidget {
  const AmbientScreenPage({super.key});

  @override
  State<AmbientScreenPage> createState() =>
      _AmbientScreenPageState();
}

class _AmbientScreenPageState
    extends State<AmbientScreenPage> {
  Timer? _clockTimer;
  Timer? _timeoutTimer;

  DateTime _now = DateTime.now();

  bool _showClock = true;
  bool _showDate = true;
  bool _showWeather = true;
  bool _showLocation = true;
  bool _showMyFarm = true;

  int _timeout = 30;

  @override
  void initState() {
    super.initState();

    _loadSettings();

    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          _now = DateTime.now();
        });
      },
    );
  }

  Future<void> _loadSettings() async {
    final clock =
        await AmbientSettingsService.showClock();

    final date =
        await AmbientSettingsService.showDate();

    final weather =
        await AmbientSettingsService.showWeather();

    final location =
        await AmbientSettingsService.showLocation();

    final myFarm =
        await AmbientSettingsService.showMyFarm();

    final timeout =
        await AmbientSettingsService.getTimeout();

    if (!mounted) return;

    setState(() {
      _showClock = clock;
      _showDate = date;
      _showWeather = weather;
      _showLocation = location;
      _showMyFarm = myFarm;
      _timeout = timeout;
    });

    _startTimeout();
  }

  void _startTimeout() {
    _timeoutTimer?.cancel();

    if (_timeout <= 0) {
      return;
    }

    _timeoutTimer = Timer(
      Duration(seconds: _timeout),
      () async {
        await AmbientScreenService.close();
      },
    );
  }

  String get _time {
    final hour =
        _now.hour.toString().padLeft(2, '0');

    final minute =
        _now.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  String get _date {
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

    return '${days[_now.weekday - 1]}, '
        '${_now.day} ${months[_now.month - 1]} '
        '${_now.year}';
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    _timeoutTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          AmbientScreenService.close();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF07130B),
                Colors.black,
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    if (_showClock)
                      Text(
                        _time,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 76,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                        ),
                      ),

                    if (_showDate) ...[
                      const SizedBox(height: 8),
                      Text(
                        _date,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],

                    if (_showWeather) ...[
                      const SizedBox(height: 42),
                      _weatherCard(),
                    ],

                    if (_showMyFarm) ...[
                      const SizedBox(height: 38),
                      _myFarmCard(),
                    ],

                    if (_showLocation) ...[
                      const SizedBox(height: 26),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white38,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Asyut, Egypt',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 30),

                    const Text(
                      'Tap to exit',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _weatherCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wb_sunny_rounded,
            color: Colors.amber,
            size: 42,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                '32°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sunny',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _myFarmCard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.eco_rounded,
              color: Colors.greenAccent,
              size: 32,
            ),
            const SizedBox(width: 10),
            const Text(
              'MyFarm',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Smart Plant Monitoring',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}