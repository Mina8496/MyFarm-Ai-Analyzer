import 'package:flutter/material.dart';
import 'package:myfarm/features/toolbox/domain/repositories/toolbox_repository.dart';
import 'package:myfarm/features/toolbox/presentation/view/widgets/alarm_notification_service.dart';
import 'package:myfarm/features/toolbox/toolbox_injector.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late final ToolboxRepository _repo;
  late final AlarmNotificationService _notifications;
  List<DateTime> _alarms = [];
  final Set<DateTime> _disabled = {};

  @override
  void initState() {
    super.initState();
    setupToolboxInjector();
    _repo = gi<ToolboxRepository>();
    _notifications = gi<AlarmNotificationService>();
    _init();
  }

  Future<void> _init() async {
    await _notifications.init();
    await _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final list = await _repo.getAlarms();
    setState(() => _alarms = list);
  }

  Future<void> _addAlarm() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked == null) return;

    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    try {
      await _repo.addAlarm(dt);
      await _notifications.scheduleDailyAlarm(dt);
      await _loadAlarms();

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تمت إضافة المنبه')));
    } catch (e) {
      // لو الجدولة فشلت (إذن مرفوض)، امسح المنبه من الـ repo عشان مايفضلش "شبح"
      await _repo.removeAlarm(dt);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'محتاج تسمح بإذن "المنبهات والتذكيرات" من إعدادات الجهاز عشان المنبه يشتغل',
          ),
        ),
      );
    }
  }

  Future<void> _removeAlarmAt(int index) async {
    final target = _alarms[index];
    await _notifications.cancelAlarm(target);
    await _repo.removeAlarm(target);
    await _loadAlarms();
  }

  Future<void> _toggleAlarm(DateTime time, bool enabled) async {
    setState(() {
      if (enabled) {
        _disabled.remove(time);
      } else {
        _disabled.add(time);
      }
    });
    if (enabled) {
      await _notifications.scheduleDailyAlarm(time);
    } else {
      await _notifications.cancelAlarm(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المنبه')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _alarms.isEmpty
            ? const Center(child: Text('لا توجد منبهات بعد'))
            : ListView.builder(
                itemCount: _alarms.length,
                itemBuilder: (context, i) {
                  final t = _alarms[i];
                  final formatted = TimeOfDay.fromDateTime(t).format(context);
                  final isEnabled = !_disabled.contains(t);
                  return Dismissible(
                    key: ValueKey(t.toIso8601String()),
                    onDismissed: (_) => _removeAlarmAt(i),
                    background: Container(color: Colors.redAccent),
                    child: ListTile(
                      leading: const Icon(Icons.alarm),
                      title: Text(formatted),
                      trailing: Switch(
                        value: isEnabled,
                        onChanged: (val) => _toggleAlarm(t, val),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAlarm,
        child: const Icon(Icons.add_alarm),
      ),
    );
  }
}
