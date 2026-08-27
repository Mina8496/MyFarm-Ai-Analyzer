import 'package:flutter/material.dart';

import '../../data/ambient_screen_service.dart';
import '../../data/ambient_settings_service.dart';
import 'package:flutter/services.dart';

class AmbientSettingsPage extends StatefulWidget {
  const AmbientSettingsPage({super.key});

  @override
  State<AmbientSettingsPage> createState() => _AmbientSettingsPageState();
}

class _AmbientSettingsPageState extends State<AmbientSettingsPage> {
    static const MethodChannel _ambientChannel = MethodChannel('myfarm_ambient');
  bool _enabled = false;

  bool _showClock = true;
  bool _showDate = true;
  bool _showWeather = true;
  bool _showLocation = true;
  bool _showMyFarm = true;

  int _timeout = 30;

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await AmbientSettingsService.isEnabled();

    final clock = await AmbientSettingsService.showClock();

    final date = await AmbientSettingsService.showDate();

    final weather = await AmbientSettingsService.showWeather();

    final location = await AmbientSettingsService.showLocation();

    final myFarm = await AmbientSettingsService.showMyFarm();

    final timeout = await AmbientSettingsService.getTimeout();

    if (!mounted) return;

    setState(() {
      _enabled = enabled;

      _showClock = clock;
      _showDate = date;
      _showWeather = weather;
      _showLocation = location;
      _showMyFarm = myFarm;

      _timeout = timeout;

      _loading = false;
    });
  }

  Future<void> _requestFullScreenIntentPermission() async {
    try {
      await _ambientChannel.invokeMethod('requestFullScreenIntentPermission');
    } on PlatformException catch (e) {
      debugPrint(
        'Failed to request full-screen intent permission: ${e.message}',
      );
    }
  }

  Future<void> _setEnabled(bool value) async {
    setState(() {
      _enabled = value;
    });

    await AmbientSettingsService.setEnabled(value);

    if (value) {
      await _requestFullScreenIntentPermission();
      await AmbientScreenService.startService();
    } else {
      await AmbientScreenService.stopService();
    }
  }

  Future<void> _setClock(bool value) async {
    setState(() {
      _showClock = value;
    });

    await AmbientSettingsService.setShowClock(value);
  }

  Future<void> _setDate(bool value) async {
    setState(() {
      _showDate = value;
    });

    await AmbientSettingsService.setShowDate(value);
  }

  Future<void> _setWeather(bool value) async {
    setState(() {
      _showWeather = value;
    });

    await AmbientSettingsService.setShowWeather(value);
  }

  Future<void> _setLocation(bool value) async {
    setState(() {
      _showLocation = value;
    });

    await AmbientSettingsService.setShowLocation(value);
  }

  Future<void> _setMyFarm(bool value) async {
    setState(() {
      _showMyFarm = value;
    });

    await AmbientSettingsService.setShowMyFarm(value);
  }

  Future<void> _selectTimeout() async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _timeoutOption(15),
              _timeoutOption(30),
              _timeoutOption(60),
              _timeoutOption(120),
              _timeoutOption(300),
              _timeoutOption(0),
            ],
          ),
        );
      },
    );

    if (selected == null) return;

    setState(() {
      _timeout = selected;
    });

    await AmbientSettingsService.setTimeout(selected);
  }

  Widget _timeoutOption(int seconds) {
    final String title;

    switch (seconds) {
      case 15:
        title = '15 seconds';
        break;

      case 30:
        title = '30 seconds';
        break;

      case 60:
        title = '1 minute';
        break;

      case 120:
        title = '2 minutes';
        break;

      case 300:
        title = '5 minutes';
        break;

      case 0:
        title = 'Never';
        break;

      default:
        title = '$seconds seconds';
    }

    return ListTile(
      title: Text(title),
      trailing: _timeout == seconds ? const Icon(Icons.check) : null,
      onTap: () {
        Navigator.pop(context, seconds);
      },
    );
  }

  String get _timeoutText {
    switch (_timeout) {
      case 0:
        return 'Never';

      case 60:
        return '1 minute';

      case 120:
        return '2 minutes';

      case 300:
        return '5 minutes';

      default:
        return '$_timeout seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ambient Screen')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Ambient Mode'),
            subtitle: const Text('Show MyFarm on the lock screen'),
            value: _enabled,
            onChanged: _setEnabled,
          ),

          const Divider(),

          SwitchListTile(
            title: const Text('Show Clock'),
            value: _showClock,
            onChanged: _enabled ? _setClock : null,
          ),

          SwitchListTile(
            title: const Text('Show Date'),
            value: _showDate,
            onChanged: _enabled ? _setDate : null,
          ),

          SwitchListTile(
            title: const Text('Show Weather'),
            value: _showWeather,
            onChanged: _enabled ? _setWeather : null,
          ),

          SwitchListTile(
            title: const Text('Show Location'),
            value: _showLocation,
            onChanged: _enabled ? _setLocation : null,
          ),

          SwitchListTile(
            title: const Text('Show MyFarm Info'),
            value: _showMyFarm,
            onChanged: _enabled ? _setMyFarm : null,
          ),

          const Divider(),

          ListTile(
            title: const Text('Screen timeout'),
            subtitle: Text(_timeoutText),
            trailing: const Icon(Icons.chevron_right),
            enabled: _enabled,
            onTap: _enabled ? _selectTimeout : null,
          ),

          const SizedBox(height: 24),

          if (_enabled)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilledButton.icon(
                onPressed: () {
                  AmbientScreenService.open();
                },
                icon: const Icon(Icons.fullscreen),
                label: const Text('Open Ambient Screen'),
              ),
            ),
        ],
      ),
    );
  }
}
